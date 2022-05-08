//
//  MainCoordinator.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import Foundation
import UIKit

final class MainCoordinator: RootCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start() {
        // Ideally these inits should be in somewhere else like Resolver or Some factory method
        let provider = ComicProviderImpl()
        let viewModel = ComicListViewModelImpl(provider: provider)
        viewModel.delegate = self
        let viewController = ComicListViewController(viewModel: viewModel)
        navigation.viewControllers = [viewController]
    }
}

extension MainCoordinator: ComicListViewModelDelegate {
    func showDetails(with data: ComicResponse) {
        // Ideally these inits should be in somewhere else like Resolver or Some factory method :)
        let displayData = ComicDetailDisplayData(
            title: data.safeTitle,
            description: data.transcript ?? "",
            imageURL: URL(string: data.img)
        )
        let detailViewModel = ComicDetailViewModelImpl(displayData: displayData)
        let detailViewController = ComicDetailViewController(viewModel: detailViewModel)
        navigation.pushViewController(detailViewController, animated: true)
    }
}
