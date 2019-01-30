//
//  ScanVCDelegate.swift
//  ZWallet
//
//  Created by loj on 29.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol ScanVCDelegate: class {
    func scanVCDelegateUriDetected(uri: String, sender: ScanVC)
    func scanVCDelegateCancelled(sender: ScanVC)
}
