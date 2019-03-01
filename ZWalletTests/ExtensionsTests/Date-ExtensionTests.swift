//
//  Date-ExtensionTests.swift
//  ZWalletTests
//
//  Created by loj on 27.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import XCTest


class Date_ExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_convertDateToString() {
        let d = Date(timeIntervalSince1970: 0)
        
        let stringRepresentation = d.datePart()
        
        XCTAssertEqual("19700101", stringRepresentation)
    }

    func test_checkForToday() {
        let tests = [(date: Date(), isToday: true),
                     (date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, isToday: false),
                     (date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, isToday: false)]

        for test in tests {
            let isToday = test.date.isToday()
            XCTAssertEqual(test.isToday, isToday)
        }
    }

    func test_checkForYesterday() {
        let tests = [(date: Date(), isYesterday: false),
                     (date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, isYesterday: false),
                     (date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, isYesterday: true)]

        for test in tests {
            let isYesterday = test.date.isYesterday()
            XCTAssertEqual(test.isYesterday, isYesterday)
        }
    }
}
