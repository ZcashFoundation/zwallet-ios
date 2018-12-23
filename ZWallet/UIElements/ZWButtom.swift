//
//  ZWButtom.swift
//  ZWallet
//
//  Created by loj on 23.12.18.
//  Copyright © 2018 XMR Systems LLC. All rights reserved.
//

import UIKit

@IBDesignable
class ZWButton: UIButton {

    @IBInspectable var cornerRadius: Float = 4.0 {
        didSet {
            self.setCornerRadius()
        }
    }

    @IBInspectable var borderWidth: Float = 1.0 {
        didSet {
            self.setBorderWidth()
        }
    }

    @IBInspectable var borderColor: UIColor = Colors.regularButtonColor.border {
        didSet {
            self.setBorderColor()
        }
    }

    @IBInspectable var textColor: UIColor = Colors.regularButtonColor.text {
        didSet {
            self.setTextColor()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setVisualDefaults()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualDefaults()
    }

    override func prepareForInterfaceBuilder() {
        self.setVisualDefaults()
    }

    private func setVisualDefaults() {
        self.setCornerRadius()
        self.setBorderWidth()
        self.setBorderColor()
        self.setBackgroundColor()
        self.setTextColor()
    }

    private func setCornerRadius() {
        self.layer.cornerRadius = CGFloat(self.cornerRadius)
    }

    private func setBorderWidth() {
        self.layer.borderWidth = CGFloat(self.borderWidth)
    }

    private func setBorderColor() {
        self.layer.borderColor = self.borderColor.cgColor
    }

    private func setBackgroundColor() {

    }

    private func setTextColor() {
        self.tintColor = self.textColor
    }
}
