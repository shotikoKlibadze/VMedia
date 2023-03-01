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
        Task {
            await interactor?.fetchTvChannels()
            await interactor?.fetchTvPrograms()
        }        
    }
}

extension UI.TvGuide.Presenter: TvGuideInteractorOutput {
    
    func didFetchTvChannels(tvChannels: [TvChannel]) {
        print("tvChannels:", tvChannels.count)
    }
    
    func didFetchTvProgramms(tvProgramms: [TvProgram]) {
        print("tvProgramms:", tvProgramms.count)
    }
    
    func errorFetchingTvProgramms(error: VMError) {
        print(error.errorDescription)
    }
    
    func errorFetchingTvChannels(error: VMError) {
        print(error.errorDescription)
    }
}
