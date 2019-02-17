//
//  AmountVCDelegate.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol AmountVCDelegate: class {
    func amountVCDelegateSendMaximumButtonTouched(sender: AmountVC)
    func amountVCDelegateNextButtonTouched(sender: AmountVC, amount: ZecInAtomicUnits)
    func amountVCDelegateDoneButtonTouched(sender: AmountVC, amount: ZecInAtomicUnits)
    func amountVCDelegateBackTouched(sender: AmountVC)
    func amountVCDelegateCancelTouched(sender: AmountVC)
}
