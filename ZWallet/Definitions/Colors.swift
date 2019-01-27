//
//  Colors.swift
//  ZWallet
//
//  Created by loj on 23.12.18.
//  Copyright © 2018 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit



public struct ButtonColor {
    public let background: UIColor
    public let border: UIColor
    public let text: UIColor
}


public class Colors {

    public static let zwalletColor = UIColor(displayP3Red: 0.28, green: 0.55, blue: 0.93, alpha: 1)

    public static let regularButtonColor = ButtonColor(
        background: .white,
        border: Colors.zwalletColor,
        text: Colors.zwalletColor)

    public static let defaultButtonColor = ButtonColor(
        background: Colors.zwalletColor,
        border: Colors.zwalletColor,
        text: .white)

    public static let trxDetailReceivedBackgroundColor = UIColor(red: 0.15, green: 0.7, blue: 0.32, alpha: 1)

    public static let trxDetailSentBackgroundColor = UIColor(red: 0.87, green: 0.07, blue: 0.13, alpha: 1)
}
