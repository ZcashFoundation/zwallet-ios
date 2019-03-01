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

    public var trxHistory: TrxsGroupedByDate?

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

        self.updateView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func setup() {
        self.trxTableView.dataSource = self
        self.trxTableView.delegate = self
    }

    private func updateView() {
        self.trxTableView.reloadData()
    }
}


extension HomeVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let history = self.trxHistory else { return }

        let trxDetails = history[indexPath.section].transactions[indexPath.row]
        self.delegate?.homeVCTrxCellTouched(sender: self, trxDetails: trxDetails)
    }
}


extension HomeVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let history = self.trxHistory else {
            return 0
        }
        return history.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let history = self.trxHistory else {
            return 0
        }
        return history[section].transactions.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let history = self.trxHistory else { return nil }
        guard let localizer = self.localizer else { return nil }
        let date = history[section].date
        if date.isToday() {
            return localizer.localized("global.today")
        }
        if date.isYesterday() {
            return localizer.localized("global.yesterday")
        }
        return date.formattedDate()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.trxTableView.dequeueReusableCell(withIdentifier: "TrxCell") as! HomeTrxTableViewCell

        guard let history = self.trxHistory else { return cell }
        let trxDetails = history[indexPath.section].transactions[indexPath.row]

        cell.trxDateLabel.text = trxDetails.date.formattedTime()

        switch trxDetails.direction {
        case .receive:
            cell.directionLabel.text = self.localizer?.localized("trxDetail.received")
            cell.directionImageView.image = UIImage(named: "ArrowDown")
            cell.trxAmountLabel.text = "+\(trxDetails.amount.formatted()) ZEC"
            #warning("fill in real value")
            cell.trxFiatAmountLabel.text = "+ fiat CHF"
        case .send:
            cell.directionLabel.text = self.localizer?.localized("trxDetail.sent")
            cell.directionImageView.image = UIImage(named: "ArrowUp")
            cell.trxAmountLabel.text = "-\(trxDetails.amount.formatted()) ZEC"
            #warning("fill in real value")
            cell.trxFiatAmountLabel.text = "- fiat CHF"
        }

        return cell
    }
}
