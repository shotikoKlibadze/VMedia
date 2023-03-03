//
//  TvGuideInteractor.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

extension UI.TvGuide {
    
    final class Interactor {
        
        weak var output: TvGuideInteractorOutput?
        private let networkClinet: Network.Client
        private let localService: TvGuideLocalDataService
        private let currentDate = Date()
        private let builder = ChannelCollectionBuilder()
        
        init(with localService: TvGuideLocalDataService) {
            self.networkClinet = Network.Client()
            self.localService = localService
        }
    }
}

extension UI.TvGuide.Interactor: TvGuideInteractor {
    
    func fetchTvPrograms() {
        getLocalCachedProgramsData()
    }
    
    func fetchTvChannels() {
        getLocalCachedChannelsData()
    }
}

private extension UI.TvGuide.Interactor {
    
    func getLocalCachedProgramsData() {
        localService.fetchPrograms { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(.found(date: let date, programs: let programs)) where
                CachedDataPolicy.validate(date, against: self.currentDate):
                self.output?.didFetchTvProgramms(tvProgramms: programs)
                self.builder.recieveTvPrograms(programs: programs)
                print("got programs from local")
            case .failure(_), .success(.empty), .success(.found):
                Task {
                    self.getProgramsDataFromServer
                }
                print("need to get programs from server")
            }
        }
    }
    
    func getLocalCachedChannelsData() {
        localService.fetchChannels { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(.found(date: let date, programs: let channels)) where
                CachedDataPolicy.validate(date, against: self.currentDate):
                self.output?.didFetchTvChannels(tvChannels: channels)
                print("got channels from local")
            case .failure(_), .success(.empty), .success(.found):
                Task {
                    self.getChannelsDataFromServer
                }
                print("need to get channels from server")
            }
        }
    }
    
    func getProgramsDataFromServer() async {
        let endpoint = TvGuideEndpoint<[TvChannelResponse]>.getTvChannels
        let result = await networkClinet.makeRequest(with: endpoint)
        switch result {
        case .success(let channels):
            let tvChannelEntities = channels.map({TvChannel(with: $0)})
            output?.didFetchTvChannels(tvChannels: tvChannelEntities)
        case .failure(let error):
            output?.errorFetchingTvChannels(error: error)
        }
    }
    
    func getChannelsDataFromServer() async {
        let endpoint = TvGuideEndpoint<[TvProgramResponse]>.getTvProgramms
        let result = await networkClinet.makeRequest(with: endpoint)
        switch result {
        case .success(let tvPrograms):
            let tvProgramEntities = tvPrograms.map({TvProgram(with: $0)})
            output?.didFetchTvProgramms(tvProgramms: tvProgramEntities)
        case .failure(let error):
            output?.errorFetchingTvProgramms(error: error)
        }
    }
}
