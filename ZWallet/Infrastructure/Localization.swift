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

    private var languageBundle: Bundle
    private let languageId = "en"

    public init() {
        let path = Bundle.main.path(forResource: self.languageId, ofType: "lproj")!
        self.languageBundle = Bundle(path: path)!
    }

    public func localized(_ text: String) -> String {
        return self.languageBundle.localizedString(forKey: text, value: text, table: "InfoPlist")
    }
}
