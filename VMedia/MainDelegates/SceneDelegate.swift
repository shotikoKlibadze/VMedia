//
//  SceneDelegate.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 28.02.23.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var assembler: Assembler!
    private var appRouter: MainRouter!
    
    lazy var rootController: UINavigationController = {
        let rootController = UINavigationController()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        return rootController
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        resolveDependencies()
        setupWindow(with: scene)
        start()
    }

}

private extension SceneDelegate {
    
    func resolveDependencies() {
        assembler = App.DIResolver.resolveDependenices()
    }
    
    func setupWindow(with scene: UIWindowScene) {
        let window = UIWindow(frame: scene.coordinateSpace.bounds)
        window.backgroundColor = UIColor.white
        window.windowScene = scene
        self.window = window
    }
    
    func start() {
        let baseRouter = assembler.resolver.resolve(MainRouter.self, argument: rootController)
        appRouter = baseRouter
        baseRouter?.show(animated: false)
    }
}

