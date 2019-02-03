//
//  ZWKeyboardLayoutConstraint.swift
//  ZWallet
//
//  Created by loj on 13.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


public class ZWKeyboardLayoutConstraint: NSLayoutConstraint {

    private var offset : CGFloat = 0
    private var keyboardVisibleHeight : CGFloat = 0

    override public func awakeFromNib() {
        super.awakeFromNib()

        self.offset = self.constant

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShows(_:)),
                                               name: UIWindow.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHides(_:)),
                                               name: UIWindow.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShows(_:)),
                                               name: UIWindow.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShows(_:)),
                                               name: UIWindow.keyboardDidChangeFrameNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func keyboardShows(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }

        if let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = frameValue.cgRectValue
            self.keyboardVisibleHeight = frame.size.height
        }

        self.updateConstant()
        self.animate(with: userInfo)
    }

    @objc
    private func keyboardHides(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }

        self.keyboardVisibleHeight = 0
        self.updateConstant()
        self.animate(with: userInfo)
    }

    private func updateConstant() {
        self.constant = self.offset + self.keyboardVisibleHeight
    }

    private func animate(with userInfo: [AnyHashable : Any]) {
        switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
        case let (.some(duration), .some(curve)):
            let options = UIView.AnimationOptions(rawValue: curve.uintValue)
            UIView.animate(
                withDuration: TimeInterval(duration.doubleValue),
                delay: 0,
                options: options,
                animations: {
                    UIApplication.shared.keyWindow?.layoutIfNeeded()
                    return
            }, completion: { isFinished in })
        default:
            break
        }
    }
}
