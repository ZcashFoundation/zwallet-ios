//
//  AddressVCDelegate.swift
//  ZWallet
//
//  Created by loj on 16.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol AddressVCDelegate: class {
    func addressVCDelegateNextButtonTouched(sender: AddressVC, address: String?)
    func addressVCDelegateDoneButtonTouched(sender: AddressVC, address: String?)
    func addressVCDelegateBackTouched(sender: AddressVC)
    func addressVCDelegateCancelTouched(sender: AddressVC)
}
