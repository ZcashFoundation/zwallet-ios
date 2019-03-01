//
//  TrxHistory.swift
//  ZWallet
//
//  Created by loj on 26.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal typealias TrxsGroupedByDate = [(date: Date, transactions: [TrxDetails])]


internal protocol TrxHistoryProtocol {
    var all: [TrxDetails] { get }
    func groupedByDate() -> TrxsGroupedByDate
}


internal class TrxHistory: TrxHistoryProtocol {
    var all: [TrxDetails]
    
    init() {
        self.all = [TrxDetails]()
    }
    
    /// Grouped by date and sorted descending
    func groupedByDate() -> TrxsGroupedByDate {
        var dict = Dictionary<String, [TrxDetails]>()
        for trxDetails in self.all {
            let datePart = trxDetails.date.datePart()
            var transactions = dict[datePart] ?? [TrxDetails]()
            transactions.append(trxDetails)
            dict[datePart] = transactions
        }
        
        var result = TrxsGroupedByDate()
        for (key, value) in dict.sorted(by: { $0.key > $1.key }) {
            if let date = key.toDate() {
                result.append((date, value.sorted { $0.date > $1.date }))
            }
        }
        
        return result
    }
}
