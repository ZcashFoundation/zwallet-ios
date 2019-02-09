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

    private var iocContainer: IocContainerProtocol

    private var viewFactory: ViewFactoryProtocol
    private var localizer: Localizable

    private var mainVC: MainVC?

    internal init(navigationController: UINavigationController,
                  iocContainer: IocContainerProtocol)
    {
        self.iocContainer = iocContainer

        self.viewFactory = self.iocContainer.viewFactory
        self.localizer = self.iocContainer.localizer

        super.init(navigationController: navigationController)
    }

    internal func start() {
        self.showMainView()
    }

    private func showMainView() {
        self.mainVC = self.viewFactory.getOnboardingMainView()
        if let vc = self.mainVC {
            vc.delegate = self
            vc.localizer = self.localizer
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
}


extension OnboardingCoordinator: MainVCDelegate {

    func mainVCCreateNewWalletTouched() {
        let createNewWalletCoordinator = CreateNewWalletCoordinator(navigationController: self.navigationController,
                                                                    iocContainer: self.iocContainer)
        self.add(childCoordinator: createNewWalletCoordinator)
        createNewWalletCoordinator.delegate = self
        createNewWalletCoordinator.start()
    }

    func mainVCRecoverWalletTouched() {
        #warning("implement revocer wallet")
    }
}


extension OnboardingCoordinator: CreateNewWalletCoordinatorDelegate {

    func createNewWalletCoordinatorSuccessful(coordinator: CreateNewWalletCoordinator) {
        self.remove(childCoordinator: coordinator)
        self.delegate?.onboardingCoordinatorSuccessful(coordinator: self)
    }

    func createNewWalletCoordinatorCancelled(coordinator: CreateNewWalletCoordinator) {
        if let vc = self.mainVC {
            self.navigationController.popToViewController(vc, animated: true)
        }
    }
}
