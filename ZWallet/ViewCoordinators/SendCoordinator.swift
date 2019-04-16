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
    private var paymentParser: PaymentParserProtocol

    private var payment: PaymentProtocol

    internal init(navigationController: UINavigationController,
                  iocContainer: IocContainerProtocol)
    {
        self.iocContainer = iocContainer

        self.viewFactory = self.iocContainer.viewFactory
        self.localizer = self.iocContainer.localizer
        self.paymentParser = self.iocContainer.paymentParser

        self.payment = Payment()

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
        guard let pasteboardContent = UIPasteboard.general.string else {
            let alert = UIAlertController(title: self.localizer.localized("recipientAddress.pasteboard.empty.title"),
                                          message: self.localizer.localized("recipientAddress.pasteboard.empty.message"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.localizer.localized("global.Ok"), style: .default, handler: nil))
            sender.present(alert, animated: true, completion: nil)
            return
        }

        let result = self.paymentParser.process(uri: pasteboardContent)
        switch result {
        case .success(let payment):
            self.showValid(payment: payment, on: sender, onRetake: {})
        case .failure:
            self.showPaymentError(on: sender)
        }
    }

    func recipientAddressVCEnterManuallyButtonTouched(sender: RecipientAddressVC) {
        #warning("implement check and store")

        let viewModel = AmountVCViewModel(mode: .new(initialAmount: self.payment.amount ?? 0),
                                          availableAmount: 2208_000_000_000)
        #warning("set correct available amount")
        self.showAmountView(with: viewModel)
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

    private func showValid(payment: PaymentProtocol,
                           on viewController: UIViewController,
                           onRetake retakeHandler: @escaping () -> Void)
    {
        guard let walletAddress = payment.targetAddress else { return }
        var message = "\(self.localizer.localized("global.targetAddress")): \(walletAddress)"

        if let amount = payment.amount {
            message.append("\n\n\(self.localizer.localized("global.amount")): \(amount.formatted())")
        }

        if let memo = payment.memo {
            message.append("\n\n\(self.localizer.localized("global.memo")): \(memo)")
        }

        let alert = UIAlertController(title: self.localizer.localized("payment.title"),
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: self.localizer.localized("payment.button.take"),
                                      style: .default, handler: { _ in
                                        self.payment = payment
                                        let viewModel = AmountVCViewModel(mode: .new(initialAmount: self.payment.amount ?? 0),
                                                                          availableAmount: 2208_000_000_000)
                                        #warning("set correct available amount")
                                        self.showAmountView(with: viewModel)
        }))
        alert.addAction(UIAlertAction(title: self.localizer.localized("global.cancel"),
                                      style: .cancel,
                                      handler: { _ in retakeHandler() }))
        viewController.present(alert, animated: true, completion: nil)
    }

    private func showPaymentError(on viewController: UIViewController) {

    }
}


extension SendCoordinator: ScanVCDelegate {

    func scanVCDelegateUriDetected(uri: String, sender: ScanVC) {
        let result = self.paymentParser.process(uri: uri)
        switch result {
        case .success(let payment):
            self.showValid(payment: payment, on: sender, onRetake: { sender.resumeCapturing() })
        case .failure:
            self.showPaymentError(on: sender)
        }
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
        self.payment.amount = amount
        let viewModel = MemoVCViewModel(mode: .new(initialMemo: self.payment.memo))
        self.showMemoView(with: viewModel)
    }

    func amountVCDelegateDoneButtonTouched(sender: AmountVC, amount: ZecInAtomicUnits) {
        self.payment.amount = amount
        self.navigationController.popViewController(animated: true)
    }

    func amountVCDelegateBackTouched(sender: AmountVC) {
        self.navigationController.popViewController(animated: true)
    }

    func amountVCDelegateCancelTouched(sender: AmountVC) {
        self.delegate?.sendCoordinatorCancelled(coordinator: self)
    }

    private func showAmountView(with viewModel: AmountVCViewModel) {
        let vc = self.viewFactory.getAmountView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.viewModel = viewModel
        self.navigationController.pushViewController(vc, animated: true)
    }
}


extension SendCoordinator: MemoVCDelegate {

    func memoVCDelegateNextButtonTouched(sender: MemoVC, memo: String?) {
        self.payment.memo = memo
        self.showReviewView()
    }

    func memoVCDelegateDoneButtonTouched(sender: MemoVC, memo: String?) {
        self.payment.memo = memo
        self.navigationController.popViewController(animated: true)
    }

    func memoVCDelegateBackTouched(sender: MemoVC) {
        self.payment.memo = nil
        self.navigationController.popViewController(animated: true)
    }

    func memoVCDelegateCancelTouched(sender: MemoVC) {
        self.delegate?.sendCoordinatorCancelled(coordinator: self)
    }

    private func showMemoView(with viewModel: MemoVCViewModel) {
        let vc = self.viewFactory.getMemoVC()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.viewModel = viewModel
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
        let viewModel = AmountVCViewModel(mode: .edit(amount: self.payment.amount ?? 0),
                                          availableAmount: 2208_000_000_000)
        #warning("set correct amounts")
        self.showAmountView(with: viewModel)
    }

    func reviewVCDelegateChangeReceivingAddressTouched(sender: ReviewVC) {
        #warning("implement")

        self.showRecipientAddressView()
    }

    func reviewVCDelegateChangeMemoTouched(sender: ReviewVC) {
        let viewModel = MemoVCViewModel(mode: .edit(memo: self.payment.memo))
        self.showMemoView(with: viewModel)
    }

    private func showReviewView() {
        let vc = self.viewFactory.getReviewVC()
        vc.delegate = self
        vc.localizer = self.localizer

        #warning("set view model")
        vc.viewModel = ReviewViewModel(amount: self.payment.amount ?? 0,
                                       fiatAmount: "22.08 CHF",
                                       receivingAddress: self.payment.targetAddress ?? "",
                                       memo: self.payment.memo)

        self.navigationController.pushViewController(vc, animated: true)
    }
}
