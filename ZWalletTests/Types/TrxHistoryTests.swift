//
//  TrxHistoryTests.swift
//  ZWalletTests
//
//  Created by loj on 26.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import XCTest

class TrxHistoryTests: XCTestCase {
    
    private var testee: TrxHistory!

    override func setUp() {
        self.testee = TrxHistory()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_emptyHistory_returnsEmptyGroupedList() {
        let groupedHistory = self.testee.getGroupedByDate()
        
        XCTAssertTrue(groupedHistory.count == 0)
    }
    
    func test_nonEmptyHistory_returnsSameAmountWhenGroupedByDate() {
        let testData = self.someTestData()
        let expectedCount = testData.count
        
        self.testee.all.append(contentsOf: testData)
        
        let grouped = self.testee.getGroupedByDate()
        
        var groupedCount = 0
        for group in grouped {
            groupedCount += group.1.count
        }
        
        XCTAssertEqual(expectedCount, groupedCount)
    }
    
    func test_nonEmptyHistory_groupedListIsSortedByDateDescending() {
        self.testee.all.append(contentsOf: self.someTestData())
        
        let groupedAndSorted = self.testee.getGroupedByDate()
        
        for i in 0 ..< groupedAndSorted.count - 1 {
            let first = groupedAndSorted[i]
            let second = groupedAndSorted[i + 1]
            
            XCTAssertGreaterThan(2, 1)
            XCTAssertGreaterThan(first.0, second.0)
        }
    }
    
    
    private func someTestData() -> [TrxDetails] {
        return [TrxDetails(direction: .receive,
                           date: Date(),
                           amount: 2208,
                           address: "address 1",
                           trxId: "trx id 1",
                           memo: "memo 1"),
                TrxDetails(direction: .send,
                           date: Calendar.current.date(byAdding:.day, value: -8, to: Date())!,
                           amount: 8,
                           address: "address 2",
                           trxId: "trx id 2",
                           memo: "memo 2"),
                TrxDetails(direction: .receive,
                           date: Calendar.current.date(byAdding:.day, value: -8, to: Date())!,
                           amount: 22,
                           address: "address 3",
                           trxId: "trxid 3",
                           memo: "memo 3")]
    }
}
