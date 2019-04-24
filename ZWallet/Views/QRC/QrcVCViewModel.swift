//
//  QrcVCViewModel.swift
//  ZWallet
//
//  Created by loj on 24.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal struct QrcVCViewModel {
    let walletAddress: String
    let qrcImage: UIImage?

    init(walletAddress: String,
         qrcImage: UIImage?)
    {
        self.walletAddress = walletAddress
        self.qrcImage = qrcImage
    }
}
