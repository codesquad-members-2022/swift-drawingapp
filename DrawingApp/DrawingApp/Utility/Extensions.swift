//
//  Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import UIKit

// MARK: - Foundation Data Types
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

// MARK: - Core Graphic Data Type
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
    
    func setBackgroundColor(color: Color, alpha: Alpha = .opaque) {
        let alphaValue = alpha.convert(using: CGFloat.self) / 10
        self.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: alphaValue)
    }
    
    func setAlpha(alpha: Alpha) {
        self.alpha = alpha.convert(using: CGFloat.self) / 10
    }
}
