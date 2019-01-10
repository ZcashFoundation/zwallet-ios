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

    private var isInitialPin = true

    internal init(navigationController: UINavigationController,
                  iocContainer: IocContainerProtocol)
    {
        self.iocContainer = iocContainer

        self.viewFactory = self.iocContainer.viewFactory
        self.localizer = self.iocContainer.localizer

        super.init(navigationController: navigationController)
    }

    internal func start() {
        self.showInitialPinView()
    }
}


extension CreateNewWalletCoordinator: PinVCDelegate {

    func pinVCPinCompleted(pinEntered pin: String, viewController: PinVC) {
        if self.isInitialPin {
            self.showConfirmationPinView(initialPin: pin)
        } else {
            #warning("save pin and continue onboarding")
        }
    }

    func pinVCCancelTouched() {
        #warning("implement")
    }

    private func showInitialPinView() {
        let vc = self.viewFactory.getPinView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.pinMode = .initial
        vc.pinAutoConfirm = true
        vc.progressStep = 1
        self.navigationController.pushViewController(vc, animated: true)
    }

    private func showConfirmationPinView(initialPin: String) {
        let vc = self.viewFactory.getPinView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.pinMode = .confirm(withInitialPin: initialPin)
        vc.pinAutoConfirm = true
        vc.progressStep = 2
        self.navigationController.pushViewController(vc, animated: true)
    }
}

// sequence is:
// 1. choose a pin
// 2. re-enter pin
// 3. choose passphrase
// 4. confirm passphrase
