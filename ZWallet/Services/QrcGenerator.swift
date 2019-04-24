//
//  QrcGenerator.swift
//  ZWallet
//
//  Created by loj on 24.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import CoreImage
import Foundation
import UIKit


public class QrcGenerator {

    public static func generate(from string: String?, scale: CGFloat) -> UIImage? {
        if let filter = CIFilter(name: "CIQRCodeGenerator"),
            let data = string?.data(using: String.Encoding.ascii)
        {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel") // L(ow) M(edium) Q H(igh)
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            if let output: CIImage = filter.outputImage?.transformed(by: transform) {

                let context = CIContext(options: nil)
                if let cgImage: CGImage = context.createCGImage(output, from: output.extent) {
                    let image: UIImage? = UIImage(cgImage: cgImage)
                    return image
                }

                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
