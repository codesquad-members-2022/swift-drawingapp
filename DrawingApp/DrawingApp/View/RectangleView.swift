//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/07.
//

import UIKit

class RectangleView: UIView {
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(with rectangle: Rectangle) {
        super.init(frame: rectangle.convert(using: CGRect.self))
        self.setBackgroundColor(color: rectangle.backgroundColor, alpha: rectangle.alpha)
    }
    
    // MARK: - UI changing methods
    func setBackgroundColor(color: Color, alpha: Alpha = .opaque) {
        let alphaValue = alpha.convert(using: CGFloat.self) / 10
        self.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: alphaValue)
    }
    
    func setBackgroundColor(with alpha: CGFloat) {
        let color = self.backgroundColor?.withAlphaComponent(alpha)
        self.backgroundColor = color
    }
    
    func setAlpha(alpha: Alpha) {
        self.alpha = alpha.convert(using: CGFloat.self) / 10
    }
    
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
