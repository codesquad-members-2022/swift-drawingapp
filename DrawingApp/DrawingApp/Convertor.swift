//
//  Convertor.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/11.
//

import Foundation
import UIKit


struct Convertor {
    static func convertColor(from color: Color, alpha : Alpha) -> UIColor {
        let R = CGFloat(color.red) / 255
        let G = CGFloat(color.green) / 255
        let B = CGFloat(color.blue) / 255
        let alphaValue = CGFloat(alpha.rawValue) * 0.1
        return UIColor(red: R, green: G, blue: B, alpha: alphaValue)
    }
    
    static func colorToHexString(_ color: Color) -> String {
        let hexString = String.init(format: "#%02lX%02lX%02lX", color.red, color.green, color.blue)
        return hexString
    }

}

extension UIColor  {
    
    func convertHex() -> String {

        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}
