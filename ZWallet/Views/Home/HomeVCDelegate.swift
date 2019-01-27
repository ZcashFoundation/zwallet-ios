//
//  HomeVCDelegate.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol HomeVCDelegate: class {
    func homeVCSendButtonTouched(sender: HomeVC)
    func homeVCReceiveButtonTouched(sender: HomeVC)
    func homeVCSettingsButtonTouched(sender: HomeVC)
    func homeVCTrxCellTouched(sender: HomeVC, rowNumber: Int)
}
