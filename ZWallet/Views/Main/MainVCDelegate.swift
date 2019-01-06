//
//  MainVCDelegate.swift
//  ZWallet
//
//  Created by loj on 06.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//


internal protocol MainVCDelegate: class {
    func mainVCCreateNewWalletTouched()
    func mainVCRecoverWalletTouched()
}
