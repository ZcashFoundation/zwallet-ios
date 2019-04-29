//
//  FiatVCViewModel.swift
//  ZWallet
//
//  Created by loj on 28.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal struct FiatVCViewModel {
    let currencies: [String:[String]]

    init(currencies: [String:[String]]) {
        self.currencies = currencies
    }
}
