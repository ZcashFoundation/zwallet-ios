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
}


internal class Wallet: WalletProtocol {
    var address: String
    var balance: ZecInAtomicUnits

    init(address: String,
         balance: ZecInAtomicUnits)
    {
        self.address = address
        self.balance = balance
    }
}
