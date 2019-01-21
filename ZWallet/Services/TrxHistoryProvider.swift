//
//  TrxHistoryProvider.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public protocol TrxHistoryProviderProtocol: class {
    func add(trxDetail: TrxDetail)
    func all() -> [TrxDetail]
    func count() -> Int
    func register(observer: TrxHistoryObserver)
    func deregister(observer: TrxHistoryObserver)
}


public class TrxHistoryProvider: TrxHistoryProviderProtocol {

    private var trxHistory: [TrxDetail]
    private var observers: [TrxHistoryObserver]

    public init() {
        self.trxHistory = [TrxDetail]()
        self.observers = [TrxHistoryObserver]()
    }

    public func add(trxDetail: TrxDetail) {
        self.trxHistory.append(trxDetail)
        self.notifyAllObservers()
    }

    public func all() -> [TrxDetail] {
        return self.trxHistory
    }

    public func count() -> Int {
        return self.trxHistory.count
    }

    public func register(observer: TrxHistoryObserver) {
        self.observers.append(observer)
    }

    public func deregister(observer: TrxHistoryObserver) {
        self.observers = self.observers.filter { $0 !== observer }
    }

    private func notifyAllObservers() {
        self.observers.forEach { (observer) in
            observer.changed()
        }
    }
}
