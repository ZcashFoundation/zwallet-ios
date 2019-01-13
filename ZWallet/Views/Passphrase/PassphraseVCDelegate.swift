//
//  PassphraseVCDelegate.swift
//  ZWallet
//
//  Created by loj on 11.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol PassphraseVCDelegate: class {
    func passphraseVCCompleted(with passphrase: String, mode: PassphraseEntryMode, sender: PassphraseVC)
    func passphraseVCInvalid(sender: PassphraseVC)
}
