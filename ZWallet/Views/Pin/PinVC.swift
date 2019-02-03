//
//  PinVC.swift
//  ZWallet
//
//  Created by loj on 09.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class PinVC: UIViewController {

    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pinDotView: ZWPinDotView!

    public weak var delegate: PinVCDelegate?
    public weak var localizer: Localizable?
    public var pinMode: PinEntryMode = .initial
    public var pinAutoConfirm: Bool = false
    public var progressStep: Int = 0

    private var pinCode: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setup()
        self.updateView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.resignFirstResponder()
    }

    private func setup() {
        self.pinCode = ""
        self.pinDotView.totalDotCount = Constants.pinCodeLength
        self.pinDotView.inputDotCount = 0
        self.pinDotView.fillColor = .black
        self.progressBar.currentStep = self.progressStep
    }

    private func updateView() {

        if let localizer = self.localizer {
            switch self.pinMode {
            case .initial:
                self.titleLabel.text = localizer.localized("pin.title.initialPin")
                self.descriptionLabel.text = localizer.localized("pin.description.initialPin")
            case .confirm(withInitialPin: _):
                self.titleLabel.text = localizer.localized("pin.title.confirmPin")
                self.descriptionLabel.text = localizer.localized("pin.description.confirmPin")
            }
        }
    }
}


extension PinVC : UIKeyInput {

    override public var canBecomeFirstResponder: Bool {
        return true
    }

    public var hasText: Bool {
        return !self.pinCode.isEmpty
    }

    public func insertText(_ text: String) {
        if self.pinCode.count < Constants.pinCodeLength {
            self.pinCode.append(text)
            self.pinDotView.inputDotCount += 1
        }

        if self.pinCode.count < Constants.pinCodeLength {
            return
        }

        switch self.pinMode {
        case .initial:
            self.initialPinCompleted()
        case let .confirm(initialPin):
            self.confirmationPinCompleted(compareWith: initialPin)
        }
    }

    private func initialPinCompleted() {
        if self.pinAutoConfirm {
            self.delegate?.pinVCPinCompleted(with: self.pinCode, mode: self.pinMode, sender: self)
        }
    }

    private func confirmationPinCompleted(compareWith initialPin: String) {
        if initialPin == self.pinCode {
            if self.pinAutoConfirm {
                self.delegate?.pinVCPinCompleted(with: self.pinCode, mode: self.pinMode, sender: self)
            }
            return
        }

        self.pinDotView.shakeAnimationWithCompletion {
            self.pinCode = ""
            self.pinDotView.inputDotCount = 0
        }
    }

    public func deleteBackward() {
        if self.pinCode.count > 0 {
            self.pinCode = String(self.pinCode.dropLast())
            self.pinDotView.inputDotCount -= 1
        }
    }
}


extension PinVC: UITextInputTraits {

    public var keyboardType: UIKeyboardType {
        get { return .numberPad }
        set { }
    }

}
