//
//  SettingsVC.swift
//  ZWallet
//
//  Created by loj on 25.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var nukeWalletButton: UIButton!

    public weak var delegate: SettingsVCDelegate?
    public weak var localizer: Localizable?
    public var viewModel: SettingsVCViewModel?

    @IBAction func backButtonTouched() {
        self.delegate?.settingsVCDelegateBackTouched(sender: self)
    }

    @IBAction func nukeWalletButtonTouched() {
        self.delegate?.settingsVCDelegateNukeWalletTouched(sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let index = self.settingsTableView.indexPathForSelectedRow {
            self.settingsTableView.deselectRow(at: index, animated: true)
        }

        self.updateView()
    }

    private func setup() {
//        self.settingsTableView.dataSource = self
//        self.settingsTableView.delegate = self
    }

    public func updateView() {
        guard let localizer = self.localizer else {
            return
        }

        self.titleLabel.text = localizer.localized("settings.title")
        self.nukeWalletButton.setTitle(localizer.localized("settings.button.nukeWallet"), for: .normal)

        self.settingsTableView.reloadData()
    }

    private enum CellIdentifier: String {
        case review = "ReviewCell"
        case memo = "ReviewMemoCell"
    }

//    private var cellDefinitions: [(cell: UITableViewCell, height: Int, action: ((ReviewVC) -> Void)?)] {
//        return [(self.amountCell, 100, self.delegate?.reviewVCDelegateChangeAmountTouched),
//                (self.receivingAddressCell, 100, self.delegate?.reviewVCDelegateChangeReceivingAddressTouched),
//                (self.memoCell, 120, self.delegate?.reviewVCDelegateChangeMemoTouched)]
//    }
//
//    private var amountCell: UITableViewCell {
//        let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: CellIdentifier.review.rawValue) as! ReviewTableViewCell
//        cell.titleLabel.text = self.localizer?.localized("review.amount")
//        cell.descriptionLabel.text = self.amountDescription
//        return cell
//    }
//
//    private var receivingAddressCell: UITableViewCell {
//        let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: CellIdentifier.review.rawValue) as! ReviewTableViewCell
//        cell.titleLabel.text = self.localizer?.localized("review.receivingAddress")
//        cell.descriptionLabel.text = self.viewModel?.receivingAddress
//        return cell
//    }
//
//    private var memoCell: UITableViewCell {
//        let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: CellIdentifier.memo.rawValue) as! ReviewTableViewCell
//        cell.titleLabel.text = self.localizer?.localized("review.memo")
//        cell.descriptionLabel.text = self.viewModel?.memo
//        return cell
//    }
}


//extension SettingsVC: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(self.cellDefinitions[indexPath.row].height)
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let action = self.cellDefinitions[indexPath.row].action {
//            action(self)
//        }
//    }
//}


//extension SettingsVC: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.cellDefinitions.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return self.cellDefinitions[indexPath.row].cell
//    }
//}
