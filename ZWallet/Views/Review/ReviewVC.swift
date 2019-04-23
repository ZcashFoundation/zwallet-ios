//
//  ReviewVC.swift
//  ZWallet
//
//  Created by loj on 13.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class ReviewVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!

    public weak var delegate: ReviewVCDelegate?
    public weak var localizer: Localizable?
    public var viewModel: ReviewViewModel?

    @IBAction func backButtonTouched() {
        self.delegate?.reviewVCDelegateBackTouched(sender: self)
    }

    @IBAction func cancelButtonTouched() {
        self.delegate?.reviewVCDelegateCancelTouched(sender: self)
    }

    @IBAction func sendButtonTouched() {
        self.delegate?.reviewVCDelegateSendTouched(sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let index = self.summaryTableView.indexPathForSelectedRow {
            self.summaryTableView.deselectRow(at: index, animated: true)
        }

        self.updateView()
    }

    private func setup() {
        self.progressBar.currentStep = 4
        self.summaryTableView.dataSource = self
        self.summaryTableView.delegate = self
    }

    public func updateView() {
        guard let localizer = self.localizer else {
            return
        }

        self.titleLabel.text = localizer.localized("review.title")

        self.summaryTableView.reloadData()
    }

    private var amountDescription: String {
        #warning("implement")
        return "22.08000 ZEC (22.80 CHF)"
    }

    private enum CellIdentifier: String {
        case review = "ReviewCell"
        case memo = "ReviewMemoCell"
    }

    private var cellDefinitions: [(cell: UITableViewCell, height: Int, action: ((ReviewVC) -> Void)?)] {
        return [(self.amountCell, 100, self.delegate?.reviewVCDelegateChangeAmountTouched),
                (self.receivingAddressCell, 100, self.delegate?.reviewVCDelegateChangeReceivingAddressTouched),
                (self.memoCell, 120, self.delegate?.reviewVCDelegateChangeMemoTouched)]
    }

    private var amountCell: UITableViewCell {
        let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: CellIdentifier.review.rawValue) as! ReviewTableViewCell
        cell.titleLabel.text = self.localizer?.localized("review.amount")
        cell.descriptionLabel.text = self.amountDescription
        return cell
    }

    private var receivingAddressCell: UITableViewCell {
        let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: CellIdentifier.review.rawValue) as! ReviewTableViewCell
        cell.titleLabel.text = self.localizer?.localized("review.receivingAddress")
        cell.descriptionLabel.text = self.viewModel?.receivingAddress
        return cell
    }

    private var memoCell: UITableViewCell {
        let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: CellIdentifier.memo.rawValue) as! ReviewTableViewCell
        cell.titleLabel.text = self.localizer?.localized("review.memo")
        cell.descriptionLabel.text = self.viewModel?.memo
        return cell
    }
}


extension ReviewVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.cellDefinitions[indexPath.row].height)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let action = self.cellDefinitions[indexPath.row].action {
            action(self)
        }
    }
}


extension ReviewVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellDefinitions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cellDefinitions[indexPath.row].cell
    }
}
