//
//  Languages.swift
//  ZWallet
//
//  Created by loj on 29.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public enum LanguageId: String, CaseIterable {
    case en = "en"
    case de = "de"
}


extension Constants {

    public static let languages =
        [
            "":LanguageId.allCases
    ]
}
