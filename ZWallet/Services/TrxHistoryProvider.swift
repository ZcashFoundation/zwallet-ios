//
//  TrxHistoryProvider.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public protocol TrxHistoryProviderProtocol: class {
    func add(trxDetails: TrxDetails)
    func all() -> [TrxDetails]
    func count() -> Int
    func register(observer: TrxHistoryObservable)
    func deregister(observer: TrxHistoryObservable)
}


public class TrxHistoryProvider: TrxHistoryProviderProtocol {

    private var trxHistory: [TrxDetails]
    private var observers: [TrxHistoryObservable]

    public init() {
        self.trxHistory = [TrxDetails]()
        self.observers = [TrxHistoryObservable]()
    }

    public func add(trxDetails: TrxDetails) {
        self.trxHistory.append(trxDetails)
        self.notifyAllObservers()
    }

    public func all() -> [TrxDetails] {
        return self.trxHistory
    }

    public func count() -> Int {
        return self.trxHistory.count
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
