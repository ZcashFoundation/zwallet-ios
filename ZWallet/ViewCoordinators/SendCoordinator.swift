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

        let viewModel = AmountVCViewModel(mode: .new,
                                          availableAmount: 2208_000_000_000)
        #warning("set correct available amount")
        self.showAmountView(withViewModel: viewModel)
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

        let viewModel = AmountVCViewModel(mode: .new,
                                          availableAmount: 2208_000_000_000)
        #warning("set correct available amount")
        self.showAmountView(withViewModel: viewModel)
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

    func amountVCDelegateDoneButtonTouched(sender: AmountVC, amount: ZecInAtomicUnits) {
        #warning("store amount")

        self.navigationController.popViewController(animated: true)
    }

    func amountVCDelegateBackTouched(sender: AmountVC) {
        self.navigationController.popViewController(animated: true)
    }

    func amountVCDelegateCancelTouched(sender: AmountVC) {
        self.delegate?.sendCoordinatorCancelled(coordinator: self)
    }

    private func showAmountView(withViewModel viewModel: AmountVCViewModel) {
        let vc = self.viewFactory.getAmountView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.viewModel = viewModel
        self.navigationController.pushViewController(vc, animated: true)
    }
}


extension SendCoordinator: MemoVCDelegate {

    func memoVCDelegateNextButtonTouched(sender: MemoVC, memo: String?) {
        #warning("implement")

        self.showReviewView()
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


extension SendCoordinator: ReviewVCDelegate {

    func reviewVCDelegateBackTouched(sender: ReviewVC) {
        self.navigationController.popViewController(animated: true)
    }

    func reviewVCDelegateCancelTouched(sender: ReviewVC) {
        self.delegate?.sendCoordinatorCancelled(coordinator: self)
    }

    func reviewVCDelegateSendTouched(sender: ReviewVC) {
        #warning("implement")
    }

    func reviewVCDelegateChangeAmountTouched(sender: ReviewVC) {
        #warning("implement")

        let viewModel = AmountVCViewModel(mode: .edit(amount: 222888),
                                          availableAmount: 2208_000_000_000)
        #warning("set correct amounts")
        self.showAmountView(withViewModel: viewModel)
    }

    func reviewVCDelegateChangeReceivingAddressTouched(sender: ReviewVC) {
        #warning("implement")

        self.showRecipientAddressView()
    }

    func reviewVCDelegateChangeMemoTouched(sender: ReviewVC) {
        #warning("implement")

        self.showMemoView()
    }

    private func showReviewView() {
        let vc = self.viewFactory.getReviewVC()
        vc.delegate = self
        vc.localizer = self.localizer

        #warning("set view model")
        vc.viewModel = ReviewViewModel(amount: 2208_000_000_000_000,
                                       fiatAmount: "22.08 CHF",
                                       receivingAddress: "reveiver's address here",
                                       memo: "some memo for this transaction comes here and may be longer")

        self.navigationController.pushViewController(vc, animated: true)
    }
}
