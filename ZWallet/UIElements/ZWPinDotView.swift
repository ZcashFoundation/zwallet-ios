//
//  ZWPinDotView.swift
//  ZWallet
//
//  Created by loj on 26.12.18.
//  Copyright © 2018 XMR Systems LLC. All rights reserved.
//

import UIKit


@IBDesignable
public class ZWPinDotView: UIView {

    @IBInspectable
    public var inputDotCount = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var totalDotCount = 6 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var strokeColor = UIColor.darkGray {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var fillColor = UIColor.darkGray {
        didSet {
            setNeedsDisplay()
        }
    }

    fileprivate var radius: CGFloat = 6
    fileprivate let spacingRatio: CGFloat = 2
    fileprivate let borderWidthRatio: CGFloat = 1 / 5

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        strokeColor.setStroke()
        fillColor.setFill()

        let borderWidth = radius * borderWidthRatio
        let isOdd = (totalDotCount % 2) != 0
        let positions = getDotPositions(isOdd)

        for (index, position) in positions.enumerated() {
            if index < inputDotCount {
                let pathToFill = UIBezierPath(circleWithCenter: position, radius: (radius + borderWidth / 2), lineWidth: borderWidth)
                pathToFill.fill()
            } else {
                let pathToStroke = UIBezierPath(circleWithCenter: position, radius: radius, lineWidth: borderWidth)
                pathToStroke.stroke()
            }
        }
    }

    private var shakeCount = 0
    private var shakeDirectionLeft = false

    public func shakeAnimationWithCompletion(_ completion: @escaping () -> ()) {
        let maxShakeCount = 5
        var duration = 0.10

        let centerX = self.center.x
        let centerY = self.center.y
        var moveX: CGFloat = 5

        if shakeCount == 0 || shakeCount == maxShakeCount {
            duration *= 0.5
        } else {
            moveX *= 2
        }
        shakeAnimation(withDuration: duration, animations: {
            if !self.shakeDirectionLeft {
                self.center = CGPoint(x: centerX + moveX, y: centerY)
            } else {
                self.center = CGPoint(x: centerX - moveX, y: centerY)
            }
        }) {
            if self.shakeCount >= maxShakeCount {
                self.shakeAnimation(withDuration: duration, animations: {
                    let realCenterX = self.superview!.bounds.midX
                    self.center = CGPoint(x: realCenterX, y: centerY)
                }) {
                    self.shakeDirectionLeft = false
                    self.shakeCount = 0
                    completion()
                }
            } else {
                self.shakeCount += 1
                self.shakeDirectionLeft = !self.shakeDirectionLeft
                self.shakeAnimationWithCompletion(completion)
            }
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateRadius()
        setNeedsDisplay()
    }
}


private extension ZWPinDotView {

    func shakeAnimation(withDuration duration: TimeInterval, animations: @escaping () -> (), completion: @escaping () -> ()) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.01, initialSpringVelocity: 0.35, options: UIView.AnimationOptions(), animations: {
            animations()
        }) { _ in
            completion()
        }
    }

    func updateRadius() {
        let width = bounds.width
        let height = bounds.height
        radius = height / 2 - height / 2 * borderWidthRatio
        let spacing = radius * spacingRatio
        let count = CGFloat(totalDotCount)
        let spaceCount = count - 1
        if (count * radius * 2 + spaceCount * spacing > width) {
            radius = floor((width / (count + spaceCount)) / 2)
        } else {
            radius = floor(height / 2);
        }
        radius = radius - radius * borderWidthRatio
    }

    func getDotPositions(_ isOdd: Bool) -> [CGPoint] {
        let centerX = bounds.midX
        let centerY = bounds.midY
        let spacing = radius * spacingRatio
        let middleIndex = isOdd ? (totalDotCount + 1) / 2 : (totalDotCount) / 2
        let offSet = isOdd ? 0 : -(radius + spacing / 2)
        let positions: [CGPoint] = (1...totalDotCount).map { index in
            let i = CGFloat(middleIndex - index)
            let positionX = centerX - (radius * 2 + spacing) * i + offSet
            return CGPoint(x: positionX, y: centerY)
        }
        return positions
    }
}


internal extension UIBezierPath {
    convenience init(circleWithCenter center: CGPoint,
                     radius: CGFloat,
                     lineWidth: CGFloat)
    {
        self.init(arcCenter: center,
                  radius: radius,
                  startAngle: 0,
                  endAngle: 2.0 * CGFloat(Double.pi),
                  clockwise: false)
        self.lineWidth = lineWidth
    }
}
