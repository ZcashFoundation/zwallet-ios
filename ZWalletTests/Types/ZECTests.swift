//
//  ZECTests.swift
//  ZWalletTests
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import XCTest

class ZECTests: XCTestCase {

    func test_formatted() {
        let testCases: [(zec: ZecInAtomicUnits, expected: String)] =
            [(0, "0.0000000"),
             (2208, "0.0000000"), // due to max frac digits to show
             (22_080_000_000_000, "22.0800000")]

        for test in testCases {
            let result = test.zec.formatted()
            XCTAssertEqual(test.expected, result)
        }
    }

    func test_makeZecFromString() {
        let testCases: [(string: String?, expected: ZecInAtomicUnits?)] =
            [(nil, nil),
             ("", nil),
             (".", 0),
             (".0", 0),
             ("0", 0),
             ("22", 22_000_000_000_000),
             ("22.", 22_000_000_000_000),
             ("22.08", 22_080_000_000_000),
             ("2.2.8", nil)]

        for test in testCases {
            let zec = ZecInAtomicUnits(from: test.string)
            XCTAssertEqual(test.expected, zec)
        }
    }
}
