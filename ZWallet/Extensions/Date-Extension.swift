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
    public func dateAndTime() -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df.string(from: self)
    }

    /// Formatted time in HH:mm
    public func time() -> String {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .medium
        return df.string(from: self)
    }
}
