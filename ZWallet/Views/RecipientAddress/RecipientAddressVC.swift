//
//  RecipientAddressVC.swift
//  ZWallet
//
//  Created by loj on 28.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class RecipientAddressVC: UIViewController {

    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scanCodeButton: UIButton!
    @IBOutlet weak var pasteFromClipboardButton: UIButton!
    @IBOutlet weak var enterManuallyButton: UIButton!

    public weak var delegate: RecipientAddressDelegate?
    public weak var localizer: Localizable?

    @IBAction func scanCodeButtonTouched() {
        self.delegate?.recipientAddressVCScanButtonTouched(sender: self)
    }

    @IBAction func pasteFromClipboardButtonTouched() {
        self.delegate?.recipientAddressVCPasteFromClipboardButtonTouched(sender: self)
    }

    @IBAction func enterManuallyButtonTouched() {
        self.delegate?.recipientAddressVCEnterManuallyButtonTouched(sender: self)
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
        self.progressBar.currentStep = 1
    }

    private func updateView() {
        guard let localizer = self.localizer else {
            return
        }

        self.titelLabel.text = localizer.localized("recipientAddress.title")
        self.descriptionLabel.text = localizer.localized("recipientAddress.description")

        self.scanCodeButton.setTitle(localizer.localized("recipientAddress.scanButton"),
                                     for: .normal)
        self.pasteFromClipboardButton.setTitle(localizer.localized("recipientAddress.pasteFromClipboardButton"),
                                               for: .normal)
        self.enterManuallyButton.setTitle(localizer.localized("recipientAddress.enterManuallyButton"),
                                          for: .normal)
    }
}
