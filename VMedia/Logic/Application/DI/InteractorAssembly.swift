//
//  InteractorAssembly.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Swinject

final class InteractorAssembly: Assembly {
    
    func assemble(container: Swinject.Container) {
        container.register(UI.TvGuide.Interactor.self) { _ in
            let interactor = UI.TvGuide.Interactor(with: TvGuideLocalDataRepository())
            return interactor
        }
    }
}

