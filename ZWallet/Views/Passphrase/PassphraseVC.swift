//
//  PassphraseVC.swift
//  ZWallet
//
//  Created by loj on 11.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class PassphraseVC: UIViewController {

    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var passphraseTextField: UITextField!
    @IBOutlet weak var nextButton: ZWButton!
    @IBOutlet weak var nextButtonBottomContraint: NSLayoutConstraint!

    public weak var delegate: PassphraseVCDelegate?
    public weak var localizer: Localizable?
    public var passphraseMode: PassphraseEntryMode = .initial
    public var progressStep: Int = 0

    @IBAction func nextButtonTouched() {
        guard let passphrase = self.passphraseTextField.text else {
            return
        }

        if matches(passphrase) {
            self.delegate?.passphraseVCCompleted(with: passphrase,
                                                 mode: self.passphraseMode,
                                                 sender: self)
        } else {
            self.delegate?.passphraseVCInvalid(sender: self)
            self.passphraseTextField.text?.removeAll()
            self.updateNextButton()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
        self.updateView()
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.passphraseTextField.resignFirstResponder()
//    }

    private func setup() {
        self.passphraseTextField.text = ""
        self.passphraseTextField.becomeFirstResponder()
        self.passphraseTextField.addTarget(self,
                                           action: #selector(textFieldDidChange),
                                           for: .editingChanged)
//        self.passphraseTextField.delegate = self
        self.progressBar.currentStep = self.progressStep
        self.updateNextButton()
    }

    private func updateView() {
        if let localizer = self.localizer {
            switch self.passphraseMode {
            case .initial:
                self.titleLabel.text = localizer.localized("passphrase.title.initialPassphrase")
                self.descriptionLabel.text = localizer.localized("passphrase.description.initialPassphrase")
                self.passphraseTextField.placeholder = localizer.localized("passphrase.placeholder.initialPassphrase")
            case .confirm(withInitialPassphrase: _):
                self.titleLabel.text = localizer.localized("passphrase.title.confirmPassphrase")
                self.descriptionLabel.text = localizer.localized("passphrase.description.confirmPassphrase")
                self.passphraseTextField.placeholder = localizer.localized("passphrase.placeholder.confirmPassphrase")
            }
            self.nextButton.setTitle(localizer.localized("passphrase.next"), for: .normal)
        }
    }

    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        updateNextButton()
    }

    private func updateNextButton() {
        let passphraseLength = self.passphraseTextField.text?.count ?? 0
        if passphraseLength > 0 {
            self.nextButton.isEnabled = true
        } else {
            self.nextButton.isEnabled = false
        }
    }

    private func matches(_ passphrase: String) -> Bool {
        switch self.passphraseMode {
        case .initial:
            return true
        case let .confirm(initialPassphrase):
            return initialPassphrase == passphrase
        }
    }
}


//extension PassphraseVC: UITextFieldDelegate {
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        self.nextButton.isHidden = false
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.nextButton.isHidden = true
//    }
//}

