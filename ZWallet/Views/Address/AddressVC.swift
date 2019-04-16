//
//  AddressVC.swift
//  ZWallet
//
//  Created by loj on 16.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class AddressVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nextButton: ZWButton!

    public weak var delegate: AddressVCDelegate?
    public weak var localizer: Localizable?
    public var viewModel: AddressVCViewModel?

    @IBAction func nextButtonTouched() {
        let address = self.addressTextField.text
        guard let mode = self.viewModel?.mode else { return }

        #warning("have only one callback method, provide mode, coordinator must decide")
        switch mode {
        case .new:
            self.delegate?.addressVCDelegateNextButtonTouched(sender: self, address: address)
        case .edit(_):
            self.delegate?.addressVCDelegateDoneButtonTouched(sender: self, address: address)
        }
    }

    @IBAction func backButtonTouched() {
        self.delegate?.addressVCDelegateBackTouched(sender: self)
    }

    @IBAction func cancelTouched() {
        self.delegate?.addressVCDelegateCancelTouched(sender: self)
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
        self.addressTextField.resignFirstResponder()
    }

    private func setup() {
        self.addressTextField.addTarget(self,
                                        action: #selector(addressTextFieldDidChange(_:)),
                                        for: .editingChanged)
    }

    private func updateView() {
        self.addressTextField.becomeFirstResponder()

        guard let localizer = self.localizer else { return }

        self.addressTextField.placeholder = localizer.localized("address.address.placeholder")

        if let mode = self.viewModel?.mode {
            switch mode {
            case .new(let initialAddress):
                self.titleLabel.text = localizer.localized("address.title")
                self.addressTextField.text = initialAddress
                self.nextButton.setTitle(localizer.localized("address.next"), for: .normal)
                self.backButton.isHidden = false
                self.progressBar.isHidden = false
            case .edit(let address):
                self.titleLabel.text = localizer.localized("address.title.edit")
                self.addressTextField.text = address
                self.nextButton.setTitle(localizer.localized("global.done"), for: .normal)
                self.backButton.isHidden = true
                self.progressBar.isHidden = true
            }
        }
    }

    @objc
    private func addressTextFieldDidChange(_ sender: Any) {
        #warning("how long does an address allowed to be?")
    }
}
