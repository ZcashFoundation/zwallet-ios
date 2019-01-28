//
//  RecipientAddressDelegate.swift
//  ZWallet
//
//  Created by loj on 28.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol RecipientAddressDelegate: class {
    func recipientAddressVCScanButtonTouched(sender: RecipientAddressVC)
    func recipientAddressVCPasteFromClipboardButtonTouched(sender: RecipientAddressVC)
    func recipientAddressVCEnterManuallyButtonTouched(sender: RecipientAddressVC)
}
