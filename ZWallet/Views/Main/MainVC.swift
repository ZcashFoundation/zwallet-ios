//
//  MainVC.swift
//  ZWallet
//
//  Created by loj on 06.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var createNewWalletButton: UIButton!
    @IBOutlet weak var recoverWalletButton: UIButton!

    @IBAction func createNewWalletButtonTouched() {
        self.delegate?.mainVCCreateNewWalletTouched()
    }

    @IBAction func recoverWalletButtonTouched() {
        self.delegate?.mainVCRecoverWalletTouched()
    }

    public weak var delegate: MainVCDelegate?
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
            self.welcomeLabel.text = localizer.localized("main.welcome")
            self.createNewWalletButton.setTitle(localizer.localized("main.createNewWallet"), for: .normal)
            self.recoverWalletButton.setTitle(localizer.localized("main.recoverWaller"), for: .normal)
        }
    }
}
