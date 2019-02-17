//
//  ReviewViewModel.swift
//  ZWallet
//
//  Created by loj on 14.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal struct ReviewViewModel {
    let amount: ZecInAtomicUnits
    let fiatAmount: String
    let receivingAddress: String
    let memo: String
}
