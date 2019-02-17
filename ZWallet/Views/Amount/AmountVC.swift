//
//  AmountVC.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit


class AmountVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var sendMaximumButton: ZWButton!
    @IBOutlet weak var nextButton: ZWButton!

    public weak var delegate: AmountVCDelegate?
    public weak var localizer: Localizable?
    public var viewModel: AmountVCViewModel?

    private var amount: ZecInAtomicUnits?

    @IBAction func sendMaximumButtonTouched() {
        self.delegate?.amountVCDelegateSendMaximumButtonTouched(sender: self)
    }

    @IBAction func nextButtonTouched() {
        let s = self.amountTextField.text ?? "0"
        guard let zec = ZecInAtomicUnits(from: s) else { return }
        guard let mode = self.viewModel?.mode else { return }

        switch mode {
        case .new:
            self.delegate?.amountVCDelegateNextButtonTouched(sender: self, amount: zec)
        case .edit(_):
            self.delegate?.amountVCDelegateDoneButtonTouched(sender: self, amount: zec)
        }
    }

    @IBAction func backButtonTouched() {
        self.delegate?.amountVCDelegateBackTouched(sender: self)
    }

    @IBAction func cancelButtonTouched() {
        self.delegate?.amountVCDelegateCancelTouched(sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.amountTextField.resignFirstResponder()
    }

    private func setup() {
        self.amountTextField.delegate = self
    }

    private func updateView() {
        self.amountTextField.becomeFirstResponder()
        
        guard let localizer = self.localizer else { return }

        self.currencyLabel.text = "ZEC"
        self.amountTextField.text = self.amountString()
        self.availableLabel.text = self.availableAmountString()

        self.sendMaximumButton.setTitle(localizer.localized("amount.sendMaximum"), for: .normal)

        if let mode = self.viewModel?.mode {
            switch mode {
            case .new:
                self.titleLabel.text = localizer.localized("amount.title")
                self.nextButton.setTitle(localizer.localized("amount.next"), for: .normal)
                self.backButton.isHidden = false
                self.progressBar.isHidden = false
            case .edit(let amount):
                self.amount = amount
                self.titleLabel.text = localizer.localized("amount.title.edit")
                self.nextButton.setTitle(localizer.localized("global.done"), for: .normal)
                self.backButton.isHidden = true
                self.progressBar.isHidden = true
            }
        }
    }

    private func amountString() -> String {
        guard let amount = self.amount else {
            return "0"
        }

        #warning("do not format this value, show as user typed")
        return "\(amount.formatted())"
    }

    private func availableAmountString() -> String {
        let postfix = self.localizer?.localized("amount.available") ?? "!!available"

        guard let availableAmount = self.viewModel?.availableAmount else {
            return "0 \(postfix)"
        }

        return "\(availableAmount.formatted()) \(postfix)"
    }
}


extension AmountVC: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        #warning("check for multiple decimal separators")

        #warning("check for max fraction length")

        return false
    }
}
