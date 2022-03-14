//
//  UIColor+Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/07.
//

import UIKit

typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

protocol ColorBuildable {
    init?(red: Double, green: Double, blue: Double)
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
    
    convenience init(with color: Color, alpha: Alpha = .opaque) {
        let alphaValue = alpha.convert(using: CGFloat.self)
        self.init(red: color.red / 255, green: color.green / 255, blue: color.blue / 255, alpha: alphaValue)
    }
    
    func getRGBA() -> RGBA {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    func toHexString() -> String {
        let (red, green, blue, _) = self.getRGBA()
        let RGB = Int(red * 255) << 16 | Int(green * 255) << 8 | Int(blue * 255)
        
        return String(format:"#%06x", RGB).uppercased()
    }
    
    func convert<T: ColorBuildable>(using Convertor: T.Type, multiplier: CGFloat = 1) -> T? {
        let (red, green, blue, _) = self.getRGBA()
        return Convertor.init(red: red * multiplier, green: green * multiplier, blue: blue * multiplier)
    }
}
