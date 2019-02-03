//
//  AmountVC.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class AmountVC: UIViewController {

    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var sendMaximumButton: ZWButton!
    @IBOutlet weak var nextButton: ZWButton!

    public weak var delegate: AmountVCDelegate?
    public weak var localizer: Localizable?
    public var amount: ZecInAtomicUnits?
    public var availableAmount: ZecInAtomicUnits?

    @IBAction func sendMaximumButtonTouched() {
        self.delegate?.amountVCDelegateSendMaximumButtonTouched(sender: self)
    }

    @IBAction func nextButtonTouched() {
        let s = self.amountTextField.text ?? "0"
        guard let zec = ZecInAtomicUnits(from: s) else { return }
        self.delegate?.amountVCDelegateNextButtonTouched(sender: self, amount: zec)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateView()
    }

    private func setup() {
        self.amountTextField.delegate = self
    }

    private func updateView() {
        guard let localizer = self.localizer else { return }

        self.titleLabel.text = localizer.localized("amount.title")
        self.currencyLabel.text = "ZEC"
        self.amountTextField.text = self.amountString()
        self.availableLabel.text = self.availableAmountString()

        self.sendMaximumButton.setTitle(localizer.localized("amount.sendMaximum"), for: .normal)
        self.nextButton.setTitle(localizer.localized("amount.next"), for: .normal)
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

        guard let availableAmount = self.availableAmount else {
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
