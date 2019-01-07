//
//  Coordinateable.swift
//  ZWallet
//
//  Created by loj on 06.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal class BaseCoordinator {

    internal var childCoordinators: [BaseCoordinator] = []
    internal var navigationController: UINavigationController

    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    internal func add(childCoordinator: BaseCoordinator) {
        if self.childCoordinators.contains(where: { $0 === childCoordinator }) {
            return
        }
        self.childCoordinators.append(childCoordinator)
    }

    internal func remove(childCoordinator: BaseCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
