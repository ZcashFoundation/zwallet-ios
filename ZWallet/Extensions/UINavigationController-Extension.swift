//
//  UINavigationController-Extension.swift
//  ZWallet
//
//  Created by loj on 01.03.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController {

    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
