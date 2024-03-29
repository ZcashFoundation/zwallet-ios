//
//  Constants.swift
//  ZWallet
//
//  Created by loj on 10.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal class Constants {

    public static let defaultLanguage = "en"
    public static let defaultCurrency = "USD"
    public static let defaultNodeAddress = "node.22of8.ch:2208"

    public static let pinCodeLength = 6

    public static let atomicUnitsPerZec: UInt64 = 1_000_000_000_000
    public static let numberOfFractionDigits: Int = 12
    public static let prettyPrintNumberOfFractionDigits = 7
}
