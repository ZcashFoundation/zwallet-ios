//
//  ReviewVCDelegate.swift
//  ZWallet
//
//  Created by loj on 14.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol ReviewVCDelegate: class {
    func reviewVCDelegateBackTouched(sender: ReviewVC)
    func reviewVCDelegateCancelTouched(sender: ReviewVC)
    func reviewVCDelegateSendTouched(sender: ReviewVC)
    func reviewVCDelegateChangeAmountTouched(sender: ReviewVC)
    func reviewVCDelegateChangeReceivingAddressTouched(sender: ReviewVC)
    func reviewVCDelegateChangeMemoTouched(sender: ReviewVC)
}
