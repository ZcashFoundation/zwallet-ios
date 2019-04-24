//
//  QrcVCDelegate.swift
//  ZWallet
//
//  Created by loj on 24.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol QrcVCDelegate: class {
    func qrcVCDelegateCopyButtonTouched(sender: QrcVC, address: String?)
    func qrcVCDelegateBackButtonTouched(sender: QrcVC)
}
