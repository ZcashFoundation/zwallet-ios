//
//  MemoVCViewModel.swift
//  ZWallet
//
//  Created by loj on 21.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal enum MemoVCMode {
    case new(initialMemo: String?)
    case edit(memo: String?)
}


internal struct MemoVCViewModel {
    let mode: MemoVCMode

    init(mode: MemoVCMode)
    {
        self.mode = mode
    }
}
