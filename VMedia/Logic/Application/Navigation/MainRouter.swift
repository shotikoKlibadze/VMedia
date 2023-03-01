//
//  MainRouter.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import UIKit
import Swinject

class MainRouter {

    var rootController: UINavigationController
    var resolver: Resolver

    init(rootController: UINavigationController, routerResolver: Resolver) {
        self.rootController = rootController
        self.resolver = routerResolver
    }
    
    func show(animated: Bool) {
        showTvGuide(animated: animated)
    }
}


private extension MainRouter {
    
    private func showTvGuide(animated: Bool) {
        guard let router = resolver.resolve(TvGuideRouter.self, argument: rootController) else {
            assertionFailure("Failed to resolve \(TvGuideRouter.self)")
            return
        }
        router.show(animated: animated)
    }
}


extension MainRouter {
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController.present(controller,
                               animated: animated)
    }

    func dismissModule() {
        dismissModule(animated: true)
    }

    func dismissModule(animated: Bool) {
        rootController.dismiss(animated: animated)
    }

    func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
        else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }

        rootController.pushViewController(controller, animated: animated)
    }

    func popModule() {
        rootController.popViewController(animated: true)
    }

    func pop(to moduleType: UIViewController.Type, animated: Bool) {
        guard let moduleToPop = rootController.viewControllers.first(where: { $0.isKind(of: moduleType) })
        else { return }
        
        rootController.popToViewController(moduleToPop, animated: animated)
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false, animated: true)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        setRootModule(module, hideBar: hideBar, animated: true)
    }

    func setRootModule(_ module: Presentable?,
                       hideBar: Bool,
                       animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        
        rootController.setViewControllers([controller], animated: animated)
        rootController.isNavigationBarHidden = hideBar
    }

    func setModules(_ modules: [Presentable]?, animated: Bool) {
        guard let views = modules?.compactMap({ $0.toPresent() }), !views.isEmpty
        else { return }

        rootController.setViewControllers(views, animated: animated)
    }
}
