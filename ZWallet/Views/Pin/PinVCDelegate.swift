//
//  PinVCDelegate.swift
//  ZWallet
//
//  Created by loj on 09.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation

internal protocol PinVCDelegate: class {
    func pinVCPinCompleted(pinEntered pin: String, viewController: PinVC)
    func pinVCCancelTouched()
}
