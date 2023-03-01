//
//  RouterAssembly.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Swinject

final class RouterAssembly: Assembly {
    
    func assemble(container: Swinject.Container) {
        container.register(MainRouter.self) { (resolver, rootController: UINavigationController) in
            MainRouter(rootController: rootController, routerResolver: resolver)
        }
        
        container.register(TvGuideRouter.self) { (resolver, controller: UINavigationController) in
            return TvGuideRouter(rootController: controller, routerResolver: resolver)
        }
    }
}

