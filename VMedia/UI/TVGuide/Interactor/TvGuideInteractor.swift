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
    
    func fetchTvPrograms() {
        localService.fetchTvPrograms()
    }
    
    func fetchTvChannels() {
        localService.fetchTvChannels()
        output?.didFetchTvChannels(tvChannels: [])
    }
}
