//
//  AppCoordinator.swift
//  ZWallet
//
//  Created by loj on 06.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal class AppCoordinator: BaseCoordinator {

    private var iocContainer: IocContainerProtocol

    public init(navigationController: UINavigationController,
                iocContainer: IocContainerProtocol)
    {
        self.iocContainer = iocContainer
        super.init(navigationController: navigationController)
    }

    public func start() {
        if self.hasWallet() {
            #warning("goto login")
        } else {
            self.showOnboarding()
        }
    }

    private func hasWallet() -> Bool {
        #warning("implement")
        return false
    }
}


extension AppCoordinator: OnboardingCoordinatorDelegate {

    private func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: self.navigationController,
                                                          iocContainer: self.iocContainer)
        self.add(childCoordinator: onboardingCoordinator)
        onboardingCoordinator.delegate = self
        onboardingCoordinator.start()
    }

    func onboardingCoordinatorSuccessful(coordinator: OnboardingCoordinator) {
        #warning("implement")
    }
}
