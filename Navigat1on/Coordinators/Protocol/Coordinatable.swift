//
//  Coordinatable.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 26.01.2023.
//

import UIKit

protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] { get }
    func start() -> UIViewController
    func addChildCoordinator(_ coordinator: Coordinatable)
    func removeChildCoordinator(_ coordinator: Coordinatable)
}

protocol MainCoordinatorDelegate: AnyObject {
    func pushMainTabBarController(user: User)
}
