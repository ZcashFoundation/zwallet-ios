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

        self.navigationController?.navigationBar.isHidden = true

        if let index = self.settingsTableView.indexPathForSelectedRow {
            self.settingsTableView.deselectRow(at: index, animated: true)
        }

        self.updateView()
    }

    private func setup() {
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
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
        case twoLabels = "SettingsTwoLabelsCell"
        case oneLabel = "SettingsOneLabelCell"
        case labelSwitch = "SettingsSwitchCell"
    }

    private var cellDefinitions: [(section: Int, cell: UITableViewCell, action: ((SettingsVC) -> Void)?)] {
        return [(section: 0,
                 cell:self.languageCell,
                 action: self.delegate?.settingsVCDelegateLanguageSelectionTouched),
                (section: 0,
                 cell:self.fiatCell,
                 action: self.delegate?.settingsVCDelegateFiatSelectionTouched),

                (section: 1,
                 cell:self.nodeCell,
                 action: self.delegate?.settingsVCDelegateNodeSelectionTouched),

                (section: 2,
                 cell:self.biometricCell,
                 action: self.delegate?.settingsVCDelegateBiometricSwitchTouched),
                (section: 2,
                 cell:self.resetPinCell,
                 action: self.delegate?.settingsVCDelegateResetPinTouched),
                (section: 2,
                 cell:self.displayPassphraseCell,
                 action: self.delegate?.settingsVCDelegateDisplayPassphraseTouched),
        ]
    }

    private var sectionHeaders = ["settings.generalSettings",
                                  "settings.node",
                                  "settings.securityAndPin"]

    private var languageCell: UITableViewCell {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.twoLabels.rawValue) as! SettingsTwoLabelsTableViewCell
        cell.leftLabel.text = self.localizer?.localized("settings.language")
        cell.rightLabel.text = self.viewModel?.language
        return cell
    }

    private var fiatCell: UITableViewCell {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.twoLabels.rawValue) as! SettingsTwoLabelsTableViewCell
        cell.leftLabel.text = self.localizer?.localized("settings.fiat")
        cell.rightLabel.text = self.viewModel?.currency
        return cell
    }

    private var nodeCell: UITableViewCell {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.oneLabel.rawValue) as! SettingsOneLabelTableViewCell
        cell.leftLabel.text = self.viewModel?.nodeAddress
        return cell
    }

    private var biometricCell: UITableViewCell {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.labelSwitch.rawValue) as! SettingsSwitchTableViewCell
        cell.leftLabel.text = self.localizer?.localized("settings.faceId")
        cell.switchSwitch.isOn = true
        return cell
    }

    private var resetPinCell: UITableViewCell {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.oneLabel.rawValue) as! SettingsOneLabelTableViewCell
        cell.leftLabel.text = self.localizer?.localized("settings.resetPin")
        return cell
    }

    private var displayPassphraseCell: UITableViewCell {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: CellIdentifier.oneLabel.rawValue) as! SettingsOneLabelTableViewCell
        cell.leftLabel.text = self.localizer?.localized("settings.displayPassphrase")
        return cell
    }
}


extension SettingsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItems = self.cellDefinitions
            .filter { $0.section == indexPath.section }

        if let action = sectionItems[indexPath.row].action {
            action(self)
        }
    }
}


extension SettingsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.localizer?.localized(self.sectionHeaders[section])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        let n = (cellDefinitions.map { $0.section }.max() ?? 0) + 1
        return n
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let n = self.cellDefinitions
            .filter { $0.section == section }
            .count
        return n
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionItems = self.cellDefinitions
            .filter { $0.section == indexPath.section }

        let cell = sectionItems[indexPath.row].cell
        return cell
    }
}
