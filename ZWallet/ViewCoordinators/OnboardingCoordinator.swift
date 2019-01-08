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
        let vc = self.viewFactory.getOnboardingMainView()
//        vc.delegate = self
        vc.localizer = self.localizer
        self.navigationController.pushViewController(vc, animated: true)
    }
}
