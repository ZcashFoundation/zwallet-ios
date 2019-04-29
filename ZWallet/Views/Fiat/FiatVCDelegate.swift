//
//  FiatVCDelegate.swift
//  ZWallet
//
//  Created by loj on 28.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol FiatVCDelegate: class {
    func fiatVCDelegateBackTouched(sender: FiatVC)
    func fiatVCDelegateCellTouched(sender: FiatVC)
}
