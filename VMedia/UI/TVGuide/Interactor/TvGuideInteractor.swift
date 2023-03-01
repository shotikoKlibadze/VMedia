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
        
        init(with localService: TvGuideLocalDataService) {
            self.networkClinet = Network.Client()
            self.localService = localService
        }
    }
}

extension UI.TvGuide.Interactor: TvGuideInteractor {
    
    func fetchTvPrograms() async {
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
    
    func fetchTvChannels() async {
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
}
