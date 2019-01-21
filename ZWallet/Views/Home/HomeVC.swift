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
    public weak var trxHistoryProvider: TrxHistoryProviderProtocol?

    private var trxHistory = [TrxDetail]()

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

        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.trxHistoryProvider?.register(observer: self)

        self.updateView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.trxHistoryProvider?.deregister(observer: self)
    }

    private func setup() {
        self.trxTableView.dataSource = self
    }

    private func updateView() {
        #warning("move somewhere else")
        self.trxHistory = self.trxHistoryProvider?.all() ?? [TrxDetail]()

        self.trxTableView.reloadData()
    }
}


extension HomeVC: TrxHistoryObserver {

    func changed() {
        DispatchQueue.main.async {
            self.updateView()
        }
    }
}


extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trxHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.trxTableView.dequeueReusableCell(withIdentifier: "TrxCell") as! HomeTrxTableViewCell

        let cellData = self.trxHistory[indexPath.row]
        switch cellData.direction {
        case .receive:
            cell.directionLabel.text = self.localizer?.localized("trxDetailCell.received")
            cell.directionImageView.image = UIImage(named: "ArrowDown")
        case .send:
            cell.directionLabel.text = self.localizer?.localized("trxDetailCell.sent")
            cell.directionImageView.image = UIImage(named: "ArrowUp")
        }
        cell.trxDateLabel.text = "date"
        cell.trxAmountLabel.text = "amount ZEC"
        cell.trxFiatAmountLabel.text = "fiat CHF"

        return cell
    }
}
