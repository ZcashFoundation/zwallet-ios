//
//  OnboardingCoordinator.swift
//  ZWallet
//
//  Created by loj on 07.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal class OnboardingCoordinator: BaseCoordinator {

    internal weak var delegate: OnboardingCoordinatorDelegate?

    internal init(navigationController: UINavigationController,
                  iocContainer: IocContainerProtocol)
    {
        super.init(navigationController: navigationController)
    }

    internal func start() {
        #warning("implement")
    }
}
