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
}
