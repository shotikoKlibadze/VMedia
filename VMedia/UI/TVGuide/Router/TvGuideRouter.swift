//
//  TvGuideRouter.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import UIKit
import Swinject


final class TvGuideRouter: MainRouter {
    
    var presenter: TvGuidePresenter?
    
    override func show(animated: Bool) {
        showTvGuide(animated: animated)
    }
}

private extension TvGuideRouter {
    
    func showTvGuide(animated: Bool) {
        guard let presenter = resolver.resolve(UI.TvGuide.Presenter.self, argument: self) else {
            assertionFailure("Failed to resolve \(UI.TvGuide.Presenter.self)")
            return
        }
        self.presenter = presenter
        setRootModule(presenter)
    }
}
