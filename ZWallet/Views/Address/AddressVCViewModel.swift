//
//  AddressVCViewModel.swift
//  ZWallet
//
//  Created by loj on 16.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal enum AddressVCMode {
    case new(initialAddress: String?)
    case edit(address: String?)
}


internal struct AddressVCViewModel {
    let mode: AddressVCMode

    init(mode: AddressVCMode)
    {
        self.mode = mode
    }
}
