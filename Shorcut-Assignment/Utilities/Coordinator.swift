//
//  Coordinator.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
}

protocol RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }
}

extension Array where Element == Coordinator {
    mutating func remove<T: Coordinator>(ofType: T.Type) {
        removeAll { $0 is T }
    }
}
