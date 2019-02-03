//
//  SendCoordinator.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal class SendCoordinator: BaseCoordinator {

    internal weak var delegate: SendCoordinatorDelegate?
    
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
        self.showRecipientAddressView()
    }
}


extension SendCoordinator: RecipientAddressDelegate {

    func recipientAddressVCScanButtonTouched(sender: RecipientAddressVC) {
        let vc = self.viewFactory.getScanView()
        vc.delegate = self
        vc.localizer = self.localizer
        self.navigationController.pushViewController(vc, animated: true)
    }

    func recipientAddressVCPasteFromClipboardButtonTouched(sender: RecipientAddressVC) {
        #warning("implement")
    }

    func recipientAddressVCEnterManuallyButtonTouched(sender: RecipientAddressVC) {
        #warning("implement")
        self.showAmountView()
    }

    private func showRecipientAddressView() {
        let vc = self.viewFactory.getRecipientAddressView()
        vc.delegate = self
        vc.localizer = self.localizer
        self.navigationController.pushViewController(vc, animated: true)
    }
}


extension SendCoordinator: ScanVCDelegate {

    func scanVCDelegateUriDetected(uri: String, sender: ScanVC) {
        #warning("implement")
        self.showAmountView()
    }

    func scanVCDelegateCancelled(sender: ScanVC) {
        self.navigationController.popViewController(animated: true)
    }
}


extension SendCoordinator: AmountVCDelegate {

    func amountVCDelegateSendMaximumButtonTouched(sender: AmountVC) {
        #warning("implement")
    }

    func amountVCDelegateNextButtonTouched(sender: AmountVC, amount: ZecInAtomicUnits) {
        #warning("implement")
    }

    private func showAmountView() {
        let vc = self.viewFactory.getAmountView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.amount = 0
        #warning("set correct available amount")
        vc.availableAmount = 22_080_000_000_000
        self.navigationController.pushViewController(vc, animated: true)
    }
}
