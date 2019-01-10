//
//  PinKind.swift
//  ZWallet
//
//  Created by loj on 10.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public enum PinEntryMode {
    case initial
    case confirm(withInitialPin: String)
}
