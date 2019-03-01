//
//  Wallet.swift
//  ZWallet
//
//  Created by loj on 17.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol WalletProtocol {
    var address: String { get }
    var balance: ZecInAtomicUnits { get }
    var history: TrxHistoryProtocol { get }
}


internal class xWallet: WalletProtocol {
    var address: String
    var balance: ZecInAtomicUnits
    var history: TrxHistoryProtocol

    init(address: String,
         balance: ZecInAtomicUnits,
         history: TrxHistoryProtocol)
    {
        self.address = address
        self.balance = balance
        self.history = history
    }
}
