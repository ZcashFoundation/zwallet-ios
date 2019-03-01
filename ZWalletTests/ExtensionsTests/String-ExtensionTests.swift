//
//  String-ExtensionTests.swift
//  ZWalletTests
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import XCTest


class String_ExtensionTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    public func testString_Index() {
        XCTAssertEqual("b", "abcdefg"[1])
    }

    public func testString_RangeInclusive() {
        XCTAssertEqual("bcd", "abcdefg"[1...3])
    }

    public func testString_Suffix() {
        XCTAssertEqual("de", "abcde".suffix(2))
    }

    public func test_toDouble() {
        guard let s = Locale.current.decimalSeparator else {
            print("*** skipping test, locale has no decimal separator")
            return
        }

        XCTAssertEqual(1.2, "1\(s)2".toDouble())
    }

    public func test_isValidDouble() {
        if let s = Locale.current.decimalSeparator {
            XCTAssertTrue("0".isValidDouble())
            XCTAssertTrue("0\(s)".isValidDouble())
            XCTAssertTrue("\(s)0".isValidDouble())
            XCTAssertTrue("-0\(s)1".isValidDouble())

            XCTAssertFalse(" ".isValidDouble())
            XCTAssertFalse("\(s)".isValidDouble())
            XCTAssertFalse("a".isValidDouble())
            XCTAssertFalse("\(s)a".isValidDouble())
            XCTAssertFalse("a\(s)".isValidDouble())
        }
    }

    public func test_prettyPrintDouble() {
        XCTAssertEqual(nil, "abc".prettyPrintDouble())

        XCTAssertEqual("0", "".prettyPrintDouble())
        XCTAssertEqual("0", "00".prettyPrintDouble())
        XCTAssertEqual("1", "01".prettyPrintDouble())
        XCTAssertEqual("100", "000100".prettyPrintDouble())

        if let s = Locale.current.decimalSeparator {
            XCTAssertEqual("100\(s)", "00100\(s)".prettyPrintDouble())
            XCTAssertEqual(nil, "\(s)".prettyPrintDouble())
            XCTAssertEqual("0\(s)10", "\(s)10".prettyPrintDouble())
            XCTAssertEqual("0\(s)00100", "0000\(s)00100".prettyPrintDouble())
        }
    }
    
    public func test_convertToDate() {
        guard let date = "20180822".toDate() else {
            XCTFail("failed to convert string date into date")
            return
        }
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        XCTAssertEqual(2018, year)
        XCTAssertEqual(8, month)
        XCTAssertEqual(22, day)
    }
}
