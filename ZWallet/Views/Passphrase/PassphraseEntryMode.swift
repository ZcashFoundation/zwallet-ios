//
//  PassphraseEntryMode.swift
//  ZWallet
//
//  Created by loj on 11.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public enum PassphraseEntryMode {
    case initial
    case confirm(withInitialPassphrase: String)
}
