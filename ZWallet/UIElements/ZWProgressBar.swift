//
//  ZWProgressBar.swift
//  ZWallet
//
//  Created by loj on 23.12.18.
//  Copyright © 2018 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
public class ZWProgressBar: UIView {

    @IBInspectable
    public var totalSteps = 4 {
        didSet {
            self.setup()
            setNeedsDisplay()
        }
    }

    /// Current step being in progress.
    /// Must be in range 0...totalSteps
    @IBInspectable
    public var currentStep = 1 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var borderColor: UIColor = .lightGray {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var fillColor: UIColor = Colors.zwalletColor {
        didSet {
            setNeedsDisplay()
        }
    }

    fileprivate let radius: CGFloat = 8
    fileprivate let dividerLength: CGFloat = 16
    fileprivate let space: CGFloat = 3

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.drawDividers()
        self.drawIndicators()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        self.setVisualDefaults()
    }

    public override func prepareForInterfaceBuilder() {
        self.setVisualDefaults()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setup()
        setNeedsDisplay()
    }

    private func setVisualDefaults() {

    }

    private var dividers = [UIView]()
    private var indicators = [UIView]()

    private func setup() {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.setupDividers()
        self.setupIndicators()
    }

    private func setupDividers() {
        let xOffset = self.contentXOffset() + 2 * self.radius + space
        let xDelta = 2 * self.radius + space + self.dividerLength + space
        let yOffset = self.radius - (self.borderWidth / 2)
        self.dividers = [UIView]()
        for i in 0 ..< self.totalSteps - 1 {
            let divider = UIView(frame: CGRect(x: xOffset + xDelta * CGFloat(i),
                                               y: yOffset,
                                               width: self.dividerLength,
                                               height: self.borderWidth))
            divider.backgroundColor = self.borderColor
            self.dividers.append(divider)
            self.addSubview(divider)
        }

        self.indicators = (0 ..< self.totalSteps).map { _ in UIView() }
    }

    private func setupIndicators() {
        let xOffset = self.contentXOffset()
        let xDelta = 2 * self.radius + space + self.dividerLength + space
        let yOffset = CGFloat(0)

        self.indicators = [UIView]()

        for i in 0 ..< self.totalSteps {
            let indicator = UIView(frame: CGRect(x: xOffset + xDelta * CGFloat(i),
                                                 y: yOffset,
                                                 width: 2 * self.radius,
                                                 height: 2 * self.radius))
            indicator.backgroundColor = .clear
            indicator.layer.cornerRadius = self.radius
            indicator.layer.borderWidth = self.borderWidth
            indicator.layer.borderColor = self.borderColor.cgColor

            let checkmarkImageView = UIImageView(image: UIImage(named: "Checkmark"))
            checkmarkImageView.frame = indicator.frame
            checkmarkImageView.contentMode = .scaleAspectFit
            indicator.addSubview(checkmarkImageView)

            self.indicators.append(indicator)
            self.addSubview(indicator)
        }
    }

    private func contentWidth() -> CGFloat {
        return (2 * self.radius) * CGFloat(self.totalSteps)
            + (self.space + self.dividerLength + self.space) * CGFloat(self.totalSteps - 1)
    }

    private func contentXOffset() -> CGFloat {
        return (self.frame.width - self.contentWidth()) / 2
    }
}


private extension ZWProgressBar {

    private func drawDividers() {
        self.drawProcessedDividers()
        self.drawUnprocessedDividers()
    }

    private func drawProcessedDividers() {
        if self.currentStep < 2 {
            return
        }
        let max = min(self.dividers.count, self.currentStep - 1)
        for i in 0 ..< max {
            let divider = self.dividers[i]
            divider.layer.borderColor = self.fillColor.cgColor
            divider.layer.backgroundColor = self.fillColor.cgColor
        }
    }

    private func drawUnprocessedDividers() {
    }

    private func drawIndicators() {
        self.drawProcessedIndicators()
        self.drawUnprocessedIndicators()
    }

    private func drawProcessedIndicators() {
        let max = min(self.indicators.count, self.currentStep)
        for i in 0 ..< max {
            let indicator = self.indicators[i]
            indicator.layer.borderColor = self.fillColor.cgColor
            indicator.layer.backgroundColor = self.fillColor.cgColor
        }
    }

    private func drawUnprocessedIndicators() {
    }
}
