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
        var builder = ChannelCollectionBuilder()
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
        buildChannelViews(from: tvChannels)
    }
    
    func didFetchTvProgramms(tvProgramms: [TvProgram]) {
        builder.recieveTvPrograms(programs: tvProgramms)
        updateViewWithPrograms()
    }
    
    func errorFetchingTvProgramms(error: VMError) {
        print(error.errorDescription)
    }
    
    func errorFetchingTvChannels(error: VMError) {
        print(error.errorDescription)
    }
}

private extension UI.TvGuide.Presenter {
    
    func buildChannelViews(from channels: [TvChannel]) {
        var views = [ChannelView]()
        for channel in channels {
            let view = ChannelView()
            view.configure(with: channel)
            views.append(view)
        }
        DispatchQueue.main.async {
            self.view?.channelViews(views: views)
        }
    }
    
    func updateViewWithPrograms() {
        let programCollection = builder.provideCollection()
        DispatchQueue.main.async {
            self.view?.programCollection(collection: programCollection)
        }
    }
}
