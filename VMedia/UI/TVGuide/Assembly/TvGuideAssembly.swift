//
//  TvGuideAssembly.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation
import Swinject

extension UI.TvGuide {
    
    final class Assembly: Swinject.Assembly {
        
       //typealias View = TvGuideViewController
        typealias Router = TvGuideRouter
        typealias View = TvGuideViewController2
        
        func assemble(container: Swinject.Container) {
            container.register(Presenter.self) { (resolver, router: Router) in
                let presenter = Presenter()
                let interactor = resolver.resolve(UI.TvGuide.Interactor.self)
                let view = View.loadFromStoryboard()
                presenter.router = router
                presenter.interactor = interactor
                presenter.view = view
                view.output = presenter
                interactor?.output = presenter
                return presenter
            }
        }
    }
}
