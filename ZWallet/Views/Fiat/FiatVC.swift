//
//  FiatVC.swift
//  ZWallet
//
//  Created by loj on 28.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class FiatVC: UITableViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    public weak var delegate: FiatVCDelegate?
    public weak var localizer: Localizable?
    public var viewModel: FiatVCViewModel?

    private var currencies: [String:[String]] {
        get {
            return self.viewModel?.currencies ?? [String:[String]]()
        }
    }

    @IBAction func backButtonTouched() {
        self.delegate?.fiatVCDelegateBackTouched(sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
    }

    private func setup() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func update() {
        self.title = self.localizer?.localized("fiat.title")
        self.searchBar.placeholder = self.localizer?.localized("general.search")
    }

    private lazy var sectionTitles: [String] = {
        return self.currencies
            .keys
            .sorted { $0 < $1 }
    }()

    public func value(atRow row: Int, inSection section: Int) -> String? {
        let key = self.sectionTitles[section]
        guard let values = self.currencies[key] else { return nil }
        let value = values[row]
        return value
    }

    private enum CellIdentifiers: String {
        case indexCell = "FiatIndexCell"
        case currencyCell = "FiatCurrencyCell"
    }
}


extension FiatVC {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.currencies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.sectionTitles[section]
        let values = currencies[key] ?? [String]()

        return values.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return self.getCell(forIndex: self.sectionTitles[indexPath.section])
        }
        return self.getCell(forCurrency: self.value(atRow: indexPath.row - 1, inSection: indexPath.section) ?? "?")
    }

    private func getCell(forIndex index: String) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.indexCell.rawValue) as! FiatIndexTableViewCell
        cell.indexLabel.text = index
        return cell
    }

    private func getCell(forCurrency currency: String) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.currencyCell.rawValue) as! FiatCurrencyTableViewCell
        cell.currenyIdLabel.text = currency
        cell.currencyNameLabel.text = self.localizer?.localized(currency)
        return cell
    }
}
