//
//  TrxHistoryProviderTests.swift
//  ZWalletTests
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import XCTest
import ZWallet


class TrxHistoryProviderTests: XCTestCase {

    private var testee: TrxHistoryProvider!

    override func setUp() {
        self.testee = TrxHistoryProvider()
    }

    func test_EmptyHistory_ReturnsEmptyList() {
        let trxList = self.testee.all()
        XCTAssertTrue(trxList.isEmpty)
    }

    func test_WhenAddingAnElement_ThenListContainsThisElement() {
        let trxDetails = self.getTrxDetails()

        self.testee.add(trxDetails: trxDetails)

        let trxList = self.testee.all()
        XCTAssertFalse(trxList.isEmpty)

        let element = trxList[0]

        XCTAssertEqual(element.direction, trxDetails.direction)
        XCTAssertEqual(element.date, trxDetails.date)
        XCTAssertEqual(element.amount, trxDetails.amount)
        XCTAssertEqual(element.address, trxDetails.address)
        XCTAssertEqual(element.trxId, trxDetails.trxId)
        XCTAssertEqual(element.memo, trxDetails.memo)
    }

    func test_WhenAddingAnElement_ThenNotifyObservers() {
        let observer = ObserverMock()
        self.testee.register(observer: observer)

        self.testee.add(trxDetails: self.getTrxDetails())

        XCTAssertTrue(observer.isNotified)
    }

    func test_WhenAddingAnElement_ThenCountIsIncremented() {
        let countBefore = self.testee.count()

        self.testee.add(trxDetails: self.getTrxDetails())

        let countAfter = self.testee.count()
        XCTAssertTrue(countAfter == countBefore + 1)
    }

    func test_WhenRemovingObserver_ThenThisObserverIsNoLongerNotified() {
        let observer = ObserverMock()
        self.testee.register(observer: observer)
        self.testee.deregister(observer: observer)

        self.testee.add(trxDetails: self.getTrxDetails())

        XCTAssertFalse(observer.isNotified)
    }

    private func getTrxDetails() -> TrxDetails {
        return TrxDetails(direction: .receive,
                          date: Date.init(),
                          amount: 2208,
                          address: "22of8.ch",
                          trxId: "2208",
                          memo: "22.08")
    }
}


private class ObserverMock: TrxHistoryObservable {

    public var isNotified = false

    func changed() {
        self.isNotified = true
    }
}

