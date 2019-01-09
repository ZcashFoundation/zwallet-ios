//
//  CreateNewWalletCoordinator.swift
//  ZWallet
//
//  Created by loj on 09.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal class CreateNewWalletCoordinator: BaseCoordinator {

    internal weak var delegate: CreateNewWalletCoordinatorDelegate?

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
        self.showPinView()
    }
}


extension CreateNewWalletCoordinator: PinVCDelegate {

    func pinVCNextTouched() {
        #warning("implement")
    }

    func pinVCCancelTouched() {
        #warning("implement")
    }

    private func showPinView() {
        let vc = self.viewFactory.getPinView()
        vc.delegate = self
        vc.localizer = self.localizer
        self.navigationController.pushViewController(vc, animated: true)
    }
}

// sequence is:
// 1. choose a pin
// 2. re-enter pin
// 3. choose passphrase
// 4. confirm passphrase
