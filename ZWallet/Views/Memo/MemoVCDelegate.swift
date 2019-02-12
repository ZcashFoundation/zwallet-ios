//
//  AmountVCDelegate.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol MemoVCDelegate: class {
    func memoVCDelegateNextButtonTouched(sender: MemoVC, memo: String?)
    func memoVCDelegateBackTouched(sender: MemoVC)
    func memoVCDelegateCancelTouched(sender: MemoVC)
}
