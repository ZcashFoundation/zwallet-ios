//
//  Localization.swift
//  ZWallet
//
//  Created by loj on 06.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol Localizable: class {
    func localized(_ text: String) -> String
}


internal class Localization: Localizable {

    func localized(_ text: String) -> String {
        return NSLocalizedString(text, comment: text)
    }
}
