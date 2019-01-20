//
//  HomeVC.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var fiatBalanceLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var trxTableView: UITableView!

    public weak var delegate: HomeVCDelegate?
    public weak var localizer: Localizable?

    @IBAction func sendButtonTouched() {
        self.delegate?.homeVCSendButtonTouched(sender: self)
    }

    @IBAction func receiveButtonTouched() {
        self.delegate?.homeVCReceiveButtonTouched(sender: self)
    }

    @IBAction func settingsButtonTouched() {
        self.delegate?.homeVCSettingsButtonTouched(sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setup()
        self.updateView()
    }

    private func setup() {

    }

    private func updateView() {

    }
}
