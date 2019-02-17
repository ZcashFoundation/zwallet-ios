//
//  AmountVCViewModel.swift
//  ZWallet
//
//  Created by loj on 17.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal enum AmountVCMode {
    case new
    case edit(amount: ZecInAtomicUnits)
}


internal struct AmountVCViewModel {
    let mode: AmountVCMode
    let availableAmount: ZecInAtomicUnits

    init(mode: AmountVCMode,
         availableAmount: ZecInAtomicUnits)
    {
        self.mode = mode
        self.availableAmount = availableAmount
    }
}
