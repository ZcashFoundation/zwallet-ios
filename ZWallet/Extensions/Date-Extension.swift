//
//  Date-Extension.swift
//  ZWallet
//
//  Created by loj on 27.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


extension Date {

    /// Formatted date and time
    /// localized like "Mar 1, 2019 at 8:08:08 AM"
    public func formattedDateAndTime() -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df.string(from: self)
    }

    /// Formatted date
    /// localized like "Mar 1, 2019"
    public func formattedDate() -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df.string(from: self)
    }

    /// Formatted time
    /// localized like "8:08:08 AM"
    public func formattedTime() -> String {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .medium
        return df.string(from: self)
    }
    
    /// Formatted date as yyyyMMdd
    public func datePart() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd"
        return df.string(from: self)
    }

    public func isToday() -> Bool {
        let today = Date().datePart()
        let me = self.datePart()

        return today.elementsEqual(me)
    }

    public func isYesterday() -> Bool {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())?
            .datePart() ?? ""
        let me = self.datePart()

        return yesterday.elementsEqual(me)
    }
}
