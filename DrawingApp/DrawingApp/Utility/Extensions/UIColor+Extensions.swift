//
//  UIColor+Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/07.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
    
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
        let rgb = Int(red * 255) << 16 | Int(green * 255) << 8 | Int(blue * 255)
        
        return String(format:"#%06x", rgb).uppercased()
    }
}
