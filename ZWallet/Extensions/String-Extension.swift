//
//  String-Extension.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


extension String {

    public subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    public subscript(i: Int) -> String {
        return String(self[i] as Character)
    }

    public subscript(r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start...end])
    }
    
    /// Checks if can be converted into a double
    public func isValidDouble() -> Bool {
        guard let _ = self.toDouble() else { return false }
        return true
    }

    /// Converts string to Double using locale decimal separator
    public func toDouble() -> Double? {
        let nf = NumberFormatter()
        nf.locale = Locale.current
        guard let d = nf.number(from: self) else { return nil }
        return Double(truncating: d)
    }

    /// Adds or removes leading zero
    /// eg. "00" -> "0", ".123" -> "0.123", "" -> "0"
    /// If value is not a valid double then returns nil
    public func prettyPrintDouble() -> String? {
        if self.isEmpty {
            return "0"
        }

        if self.isValidDouble() == false {
            return nil
        }

        // When system does not define decimal separator treat self as integer string
        guard let decimalSeparator = Locale.current.decimalSeparator else {
            return self.prettyPrintInt()
        }
        if decimalSeparator.count < 1 {
            return self.prettyPrintInt()
        }

        let split = self.split(separator: decimalSeparator[0], maxSplits: 1, omittingEmptySubsequences: false)

        if split.count < 2 {
            return self.prettyPrintInt()
        }
        guard let integerPart = String(split[0]).prettyPrintInt() else { return nil }
        let fractionPart = String(split[1])

        return "\(integerPart)\(decimalSeparator)\(fractionPart)"
    }

    public func prettyPrintInt() -> String? {
        if self.isEmpty {
            return "0"
        }
        guard let asInt = Int(self) else { return nil }
        return "\(asInt)"
    }
    
    /// Converts a string of format "yyyyMMdd" into a date with time 00:00:00
    public func toDate() -> Date? {
        if self.count != 8 { return nil }
        
        guard let year = Int(self[0...3]) else { return nil }
        guard let month = Int(self[4...5]) else { return nil }
        guard let day = Int(self[6...7]) else { return nil }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        dateComponents.calendar = Calendar.current
        
        return dateComponents.date
    }
}
