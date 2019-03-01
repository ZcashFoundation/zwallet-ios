//
//  TrxDetailVC.swift
//  ZWallet
//
//  Created by loj on 22.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class TrxDetailsVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var trxDirectionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var fiatAmountLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var detailsTableView: UITableView!

    public weak var delegate: TrxDetailsVCDelegate?
    public weak var localizer: Localizable?
    public var trxDetails: TrxDetails?

    @IBAction func backButtonTouched() {
        self.delegate?.trxDetailsVCDelegateBackTouched(sender: self)
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
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
    }

    private func updateView() {
        self.updateHeader()
        self.updateDetails()
    }

    private func updateHeader() {
        guard let trxDetails = self.trxDetails else {
            return
        }

        switch trxDetails.direction {
        case .receive:
            self.headerView.backgroundColor = Colors.trxDetailReceivedBackgroundColor
            self.trxDirectionLabel.text = self.localizer?.localized("trxDetail.received")
            self.amountLabel.text = "+\(trxDetails.amount.formatted()) ZEC"
            #warning("show fiat amont")
            self.fiatAmountLabel.text = ""
        case .send:
            self.headerView.backgroundColor = Colors.trxDetailSentBackgroundColor
            self.trxDirectionLabel.text = self.localizer?.localized("trxDetail.sent")
            self.amountLabel.text = "-\(trxDetails.amount.formatted()) ZEC"
            #warning("show fiat amont")
            self.fiatAmountLabel.text = ""
        }
    }

    private func updateDetails() {
        self.detailsTableView.reloadData()
    }

    private enum CellIdentifier: String {
        case detail = "TrxDetailsCell"
        case memo = "TrxMemoCell"
    }

    private var cellDefinitions: [(cell: UITableViewCell, height: Int)] {
        get {
            return [(self.dateCell, 91),
                    (self.addressCell, 91),
                    (self.trxIdCell, 91),
                    (self.memoCell, 150)]
        }
    }

    private var dateCell: UITableViewCell {
        get {
            let cell = self.detailsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.detail.rawValue) as! TrxDetailsTableViewCell
            cell.titleLabel.text = self.localizer?.localized("trxDetail.date")
            cell.bodyLabel.text = self.trxDetails?.date.formattedDateAndTime()
            return cell
        }
    }

    private var addressCell: UITableViewCell {
        get {
            let cell = self.detailsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.detail.rawValue) as! TrxDetailsTableViewCell
            cell.titleLabel.text = self.localizer?.localized("trxDetail.sourceAddress")
            cell.bodyLabel.text = self.trxDetails?.address
            return cell
        }
    }

    private var trxIdCell: UITableViewCell {
        get {
            let cell = self.detailsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.detail.rawValue) as! TrxDetailsTableViewCell
            cell.titleLabel.text = self.localizer?.localized("trxDetail.trxId")
            cell.bodyLabel.text = self.trxDetails?.trxId
            return cell
        }
    }

    private var memoCell: UITableViewCell {
        get {
            let cell = self.detailsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.memo.rawValue) as! TrxMemoTableViewCell
            cell.titleLabel.text = self.localizer?.localized("trxDetail.memo")
            cell.bodyLabel.text = self.trxDetails?.memo
            return cell
        }
    }
}


extension TrxDetailsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.cellDefinitions[indexPath.row].height)
    }
}


extension TrxDetailsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellDefinitions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cellDefinitions[indexPath.row].cell
    }
}
