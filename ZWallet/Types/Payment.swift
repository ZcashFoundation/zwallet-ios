//
//  Payment.swift
//  ZWallet
//
//  Created by loj on 21.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol PaymentProtocol {
    var targetAddress: String? { get set }
    var amount: ZecInAtomicUnits? { get set }
    var memo: String? { get set }
}


internal class Payment: PaymentProtocol {
    var targetAddress: String? = nil
    var amount: ZecInAtomicUnits? = nil
    var memo: String? = nil
}
