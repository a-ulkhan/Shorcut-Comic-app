//
//  SceneDelegate.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        if let window = window {
            let provider = ComicProviderImpl()
            let viewModel = ComicListViewModelImpl(provider: provider)
            let viewController = ComicListViewController(viewModel: viewModel)
            let emptyNav = UINavigationController(rootViewController: viewController)
            window.rootViewController = emptyNav
            window.backgroundColor = .red
            window.makeKeyAndVisible()
        }
    }
}
