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
                print("Got programs from local data source")
            case .failure(_), .success(.empty), .success(.found):
                Task {
                    await self.getProgramsDataFromServer()
                }
                print("Local Programs data expired. Need to get programs from server")
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
                print("Got channels from local data source")
            case .failure(_), .success(.empty), .success(.found):
                Task {
                    await self.getChannelsDataFromServer()
                }
                print("Local Chanels data expired. Need to get channels from server")
            }
        }
    }
    
    func getChannelsDataFromServer() async {
        Task {
            let endpoint = TvGuideEndpoint<[TvChannelResponse]>.getTvChannels
            let result = await networkClinet.makeRequest(with: endpoint)
            switch result {
            case .success(let channels):
                let tvChannelEntities = channels.map({TvChannel(with: $0)})
                output?.didFetchTvChannels(tvChannels: tvChannelEntities)
                localService.deleteCachedChannelData { [weak self] error in
                    guard error == nil, let self else { return }
                    self.localService.cache(channels: tvChannelEntities, date: self.currentDate) { _ in }
                }
            case .failure(let error):
                output?.errorFetchingTvChannels(error: error)
            }
        }
    }
    
    func getProgramsDataFromServer() async {
        Task {
            let endpoint = TvGuideEndpoint<[TvProgramResponse]>.getTvProgramms
            let result = await networkClinet.makeRequest(with: endpoint)
            switch result {
            case .success(let tvPrograms):
                let tvProgramEntities = tvPrograms.map({TvProgram(with: $0)})
                output?.didFetchTvProgramms(tvProgramms: tvProgramEntities)
                localService.deleteCachedProgramData { [weak self] error in
                    guard error == nil, let self else { return }
                    self.localService.cache(programs: tvProgramEntities, date: self.currentDate, completion: { _ in })
                }
            case .failure(let error):
                output?.errorFetchingTvProgramms(error: error)
            }
        }
    }
}
