//
//  UIColor+Extension.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/09.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: CGFloat(alpha) / 255.0)
    }
    
    convenience init(hex: String) {
        let value = Array(hex)
        let hexRed = "\(value[2])\(value[3])"
        let hexGreen = "\(value[4])\(value[5])"
        let hexBlue = "\(value[6])\(value[7])"
        self.init(red: Int(hexRed, radix: 16)!,
                  green: Int(hexGreen, radix: 16)!,
                  blue: Int(hexBlue, radix: 16)!)
    }
}
