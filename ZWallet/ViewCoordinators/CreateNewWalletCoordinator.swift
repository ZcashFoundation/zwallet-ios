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
        self.showInitialPinView()
    }
}


extension CreateNewWalletCoordinator: PinVCDelegate {

    func pinVCPinCompleted(with pin: String, mode: PinEntryMode, sender: PinVC) {
        switch mode {
        case .initial:
            self.showConfirmationPinView(initialPin: pin)
        case let .confirm(pinCode):
            #warning("save pin")
            self.showInitialPassphraseView()
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


extension CreateNewWalletCoordinator: PassphraseVCDelegate {

    func passphraseVCCompleted(with passphrase: String, mode: PassphraseEntryMode, sender: PassphraseVC) {
        switch mode {
        case .initial:
            self.showConfirmPassphraseView(with: passphrase)
        case let .confirm(passphrase):
            #warning("save passphrase")
            self.delegate?.createNewWalletCoordinatorSuccessful(coordinator: self)
        }
    }

    func passphraseVCInvalid(sender: PassphraseVC) {
        let alert = UIAlertController(title: self.localizer.localized("passphrase.mismatch.title"),
                                      message: self.localizer.localized("passphrase.mismatch.description"),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: self.localizer.localized("global.Ok"),
                                      style: .default,
                                      handler: nil))
        sender.present(alert, animated: false, completion: nil)
    }

    private func showInitialPassphraseView() {
        let vc = self.viewFactory.getPassphraseView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.passphraseMode = .initial
        vc.progressStep = 3
        self.navigationController.pushViewController(vc, animated: true)
    }

    private func showConfirmPassphraseView(with initialPassphrase: String) {
        let vc = self.viewFactory.getPassphraseView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.passphraseMode = .confirm(withInitialPassphrase: initialPassphrase)
        vc.progressStep = 4
        self.navigationController.pushViewController(vc, animated: true)
    }
}
