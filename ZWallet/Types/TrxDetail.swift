//
//  TrxDetail.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public struct TrxDetail {
    public let direction: TrxDirection
    public let date: Date
    public let amountInAtomicUnits: UInt64
    public let address: String
    public let trxId: String
    public let memo: String

    public init(direction: TrxDirection,
                date: Date,
                amountInAtomicUnits: UInt64,
                address: String,
                trxId: String,
                memo: String)
    {
        self.direction  = direction
        self.date = date
        self.amountInAtomicUnits = amountInAtomicUnits
        self.address = address
        self.trxId = trxId
        self.memo = memo
    }
}
