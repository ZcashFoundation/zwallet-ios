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

    func recipientAddressVCBackTouched(sender: RecipientAddressVC) {
        self.navigationController.popViewController(animated: true)
    }

    func recipientAddressVCCancelTouched(sender: RecipientAddressVC) {
        self.delegate?.sendCoordinatorCancelled(coordinator: self)
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

        self.showMemoView()
    }

    func amountVCDelegateBackTouched(sender: AmountVC) {
        self.navigationController.popViewController(animated: true)
    }

    func amountVCDelegateCancelTouched(sender: AmountVC) {
        self.delegate?.sendCoordinatorCancelled(coordinator: self)
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


extension SendCoordinator: MemoVCDelegate {

    func memoVCDelegateNextButtonTouched(sender: MemoVC, memo: String?) {
        #warning("implement")
    }

    func memoVCDelegateBackTouched(sender: MemoVC) {
        self.navigationController.popViewController(animated: true)
    }

    func memoVCDelegateCancelTouched(sender: MemoVC) {
        self.delegate?.sendCoordinatorCancelled(coordinator: self)
    }

    private func showMemoView() {
        let vc = self.viewFactory.getMemoVC()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.memo = "22of8.ch"
        self.navigationController.pushViewController(vc, animated: true)
    }
}
