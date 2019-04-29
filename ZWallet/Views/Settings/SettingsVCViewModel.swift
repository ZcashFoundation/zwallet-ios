//
//  SettingsVCViewModel.swift
//  ZWallet
//
//  Created by loj on 25.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal struct SettingsVCViewModel {
    var currency: String
    var language: String
    var nodeAddress: String

    init(currency: String,
         language: String,
         nodeAddress: String)
    {
        self.currency = currency
        self.language = language
        self.nodeAddress = nodeAddress
    }
}
