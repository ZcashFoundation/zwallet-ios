//
//  SettingsVCDelegate.swift
//  ZWallet
//
//  Created by loj on 25.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol SettingsVCDelegate: class {
    func settingsVCDelegateBackTouched(sender: SettingsVC)
    func settingsVCDelegateNukeWalletTouched(sender: SettingsVC)
    func settingsVCDelegateLanguageSelectionTouched(sender: SettingsVC)
    func settingsVCDelegateFiatSelectionTouched(sender: SettingsVC)
    func settingsVCDelegateNodeSelectionTouched(sender: SettingsVC)
    func settingsVCDelegateBiometricSwitchTouched(sender: SettingsVC)
    func settingsVCDelegateResetPinTouched(sender: SettingsVC)
    func settingsVCDelegateDisplayPassphraseTouched(sender: SettingsVC)
}
