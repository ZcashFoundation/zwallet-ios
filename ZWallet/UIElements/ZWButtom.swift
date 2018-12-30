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

    @IBInspectable var cornerRadius: CGFloat = 4.0 {
        didSet {
            self.setCornerRadius()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 1.0 {
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

    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.setShadow()
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.setShadow()
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
        self.setShadow()
    }

    private func setCornerRadius() {
        self.layer.cornerRadius = self.cornerRadius
    }

    private func setBorderWidth() {
        self.layer.borderWidth = self.borderWidth
    }

    private func setBorderColor() {
        self.layer.borderColor = self.borderColor.cgColor
    }

    private func setBackgroundColor() {

    }

    private func setTextColor() {
        self.tintColor = self.textColor
    }

    private func setShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = self.shadowRadius
        self.layer.masksToBounds = false
    }
}
