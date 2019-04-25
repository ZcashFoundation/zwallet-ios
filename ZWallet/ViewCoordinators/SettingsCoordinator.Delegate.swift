//
//  SettingsCoordinatorDelegate.swift
//  ZWallet
//
//  Created by loj on 25.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol SettingsCoordinatorDelegate: class {
    func settingsCoordinatorDelegateBackTouched(coordinator: SettingsCoordinator)
}
