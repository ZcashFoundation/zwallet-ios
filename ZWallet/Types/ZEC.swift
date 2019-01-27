//
//  ZEC.swift
//  ZWallet
//
//  Created by loj on 27.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public typealias ZecInAtomicUnits = UInt64

extension ZecInAtomicUnits {

    public func formatted() -> String {
        let nf = NumberFormatter()
        nf.allowsFloats = true
        nf.minimumIntegerDigits = 1
        nf.minimumFractionDigits = Constants.prettyPrintNumberOfFractionDigits
        nf.maximumFractionDigits = Constants.prettyPrintNumberOfFractionDigits

        let zec = Double(self) / Double(Constants.atomicUnitsPerZec)
        guard let formatted = nf.string(from: NSNumber(value: zec)) else {
            return ""
        }
        return formatted
    }
}
