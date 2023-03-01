//
//  TvGuidePresenter.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import UIKit

extension UI.TvGuide {
    
    final class Presenter {
        
        var interactor: TvGuideInteractor?
        var router: TvGuideRouter?
        var view: TvGuidView?
    }
}

extension UI.TvGuide.Presenter: TvGuidePresenter {
    func toPresent() -> UIViewController? {
        view?.toPresent()
    }
}


extension UI.TvGuide.Presenter: TvGuideViewOutput {
    
    func viewDidLoad() {
        interactor?.fetchTvChannels()
        interactor?.fetchTvPrograms()
    }
}

extension UI.TvGuide.Presenter: TvGuideInteractorOutput {
    
    
    func didFetchTvChannels(tvChannels: [TvChannel]) {
        
    }
    
    func didFetchTvProgramms(tvProgramms: [TvProgram]) {
        
    }
    
    func errorFetchingTvProgramms(error: VMError) {
        
    }
    
    func errorFetchingTvChannels(error: VMError) {
        
    }
}
