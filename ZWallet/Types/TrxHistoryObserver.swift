//
//  TrxHistoryObserver.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public protocol TrxHistoryObserver: class {
    func changed()
}
