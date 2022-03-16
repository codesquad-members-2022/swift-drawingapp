//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/07.
//

import UIKit

protocol BackgroundColorable {
    func setBackgroundColor(color: Color, alpha: Alpha)
    func setBackgroundColor(with color: Color)
    func setBackgroundColor(with alpha: CGFloat)
    func setBackgroundColor(with alpha: Alpha)
}

class RectangleView: UIView  {
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(with rectangle: Rectangle) {
        self.init(frame: CGRect(with: rectangle))
        self.setBackgroundColor(color: rectangle.backgroundColor, alpha: rectangle.alpha)
    }
}

// MARK: - ShapeViewable Protocol
extension RectangleView: ShapeViewable {
    func setAlpha(_ alpha: Alpha) {
        self.setBackgroundColor(with: alpha)
    }
}

// MARK: - RectangleViewable
extension RectangleView: BackgroundColorable {
    func setBackgroundColor(color: Color, alpha: Alpha) {
        self.backgroundColor = UIColor(with: color, alpha: alpha)
    }
    
    func setBackgroundColor(with color: Color) {
        self.backgroundColor = UIColor(with: color)
    }
    
    func setBackgroundColor(with alpha: CGFloat) {
        let color = self.backgroundColor?.withAlphaComponent(alpha)
        self.backgroundColor = color
    }
    
    func setBackgroundColor(with alpha: Alpha) {
        let alphaValue = alpha.convert(using: CGFloat.self)
        let color = self.backgroundColor?.withAlphaComponent(alphaValue)
        self.backgroundColor = color
    }
}
