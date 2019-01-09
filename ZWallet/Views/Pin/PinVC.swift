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

    public weak var delegate: PinVCDelegate?
    public weak var localizer: Localizable?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
    }

    private func setup() {
        if let localizer = self.localizer {
            self.titleLabel.text = localizer.localized("pin.title.initialPin")
            self.descriptionLabel.text = localizer.localized("pin.description.initialPin")
        }
    }
}
