//
//  Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import UIKit

// MARK: - Foundation
extension Double {
    static func random(in range: ClosedRange<Double>, digits: Int) -> Double {
        let value = Double.random(in: range)
        let divisor = pow(10, Double(digits))
        return (value * divisor).rounded() / divisor
    }
}

extension String {
    static let alphanumeric = "abcdefghjklmnpqrstuvwxyz12345789"
}

// MARK: - Core Graphic
extension CGSize: SizeBuilder {}
extension CGPoint: PointBuilder {}
extension CGFloat: AlphaBuilder {}
extension CGRect: RectangleBuilder {}

// MARK: - UIKit
extension UIView {
    func setBorder(width: Int, radius: Int = 0, color: UIColor?) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color?.cgColor
    }
    
    func removeBorder() {
        self.layer.cornerCurve = .circular
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 0
        self.layer.borderColor = .none
    }
}

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
