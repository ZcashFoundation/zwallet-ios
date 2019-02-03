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

    /// Transforms a ZEC string like "22.08" into atomic units
    /// Uses the current localized decimal separator
    init?(from s: String?) {
        guard let s = s else { return nil }
        if s == "" { return nil }

        guard let separator = Locale.current.decimalSeparator else {
            guard let u = UInt64(s) else {
                return nil
            }

            self = u * Constants.atomicUnitsPerZec
            return
        }

        let components = s.components(separatedBy: separator)
        var intPart: UInt64
        var fracPart: UInt64

        if components.count == 2 {
            intPart = UInt64("0" + components[0])!
            fracPart = UInt64(components[1] + String(repeating: "0", count: Constants.numberOfFractionDigits - components[1].count))!
        } else if components.count == 1 {
            intPart = UInt64(components[0])!
            fracPart = 0
        } else {
            return nil
        }

        self = intPart * Constants.atomicUnitsPerZec + fracPart
    }

    /// Returns the current amount prettily formatted with predefined number of fractional digits
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
