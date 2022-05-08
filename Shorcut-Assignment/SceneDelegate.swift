//
//  SceneDelegate.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    // Main coordinator should be retained
    var mainCoordinator: MainCoordinator?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        if let window = window {
            let navigationController = UINavigationController()
            mainCoordinator = MainCoordinator(navigation: navigationController)
            window.rootViewController = navigationController
            window.backgroundColor = .white
            window.makeKeyAndVisible()
            mainCoordinator?.start()
        }
    }
}
