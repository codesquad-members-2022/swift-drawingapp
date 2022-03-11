//
//  Convertor.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/11.
//

import Foundation
import UIKit


struct Convertor {
    
    
    static func convertColor(from color: Color) -> UIColor {
        let R = CGFloat(color.red) / 255
        let G = CGFloat(color.green) / 255
        let B = CGFloat(color.blue) / 255
        return UIColor(red: R, green: G, blue: B, alpha: 1)
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
