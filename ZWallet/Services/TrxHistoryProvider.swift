//
//  TrxHistoryProvider.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol TrxHistoryProviderProtocol: class {
    func add(trxDetails: TrxDetails)
    func count() -> Int
    func groupedByDate() -> TrxsGroupedByDate
    func register(observer: TrxHistoryObservable)
    func deregister(observer: TrxHistoryObservable)
}


internal class TrxHistoryProvider: TrxHistoryProviderProtocol {

    private var trxHistory: TrxHistory
    private var observers: [TrxHistoryObservable]

    public init() {
        self.trxHistory = TrxHistory()
        self.observers = [TrxHistoryObservable]()
    }

    public func add(trxDetails: TrxDetails) {
        self.trxHistory.all.append(trxDetails)
        self.notifyAllObservers()
    }

   public func count() -> Int {
        return self.trxHistory.all.count
    }

    func groupedByDate() -> TrxsGroupedByDate {
        return self.trxHistory.groupedByDate()
    }

    public func register(observer: TrxHistoryObservable) {
        self.observers.append(observer)
    }

    public func deregister(observer: TrxHistoryObservable) {
        self.observers = self.observers.filter { $0 !== observer }
    }

    private func notifyAllObservers() {
        self.observers.forEach { (observer) in
            observer.changed()
        }
    }
}
