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
        let trxDetail = self.getTrxDetail()

        self.testee.add(trxDetail: trxDetail)

        let trxList = self.testee.all()
        XCTAssertFalse(trxList.isEmpty)

        let element = trxList[0]

        XCTAssertEqual(element.direction, trxDetail.direction)
        XCTAssertEqual(element.date, trxDetail.date)
        XCTAssertEqual(element.amountInAtomicUnits, trxDetail.amountInAtomicUnits)
        XCTAssertEqual(element.address, trxDetail.address)
        XCTAssertEqual(element.trxId, trxDetail.trxId)
        XCTAssertEqual(element.memo, trxDetail.memo)
    }

    func test_WhenAddingAnElement_ThenNotifyObservers() {
        let observer = ObserverMock()
        self.testee.register(observer: observer)

        self.testee.add(trxDetail: self.getTrxDetail())

        XCTAssertTrue(observer.isNotified)
    }

    private func getTrxDetail() -> TrxDetail {
        return TrxDetail(direction: .receive,
                         date: Date.init(),
                         amountInAtomicUnits: 2208,
                         address: "22of8.ch",
                         trxId: "2208",
                         memo: "22.08")
    }
}


private class ObserverMock: TrxHistoryObserver {

    public var isNotified = false

    func changed() {
        self.isNotified = true
    }
}

