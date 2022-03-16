//
//  BaseView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/16.
//

import UIKit

protocol ShapeViewable: UIView {
    func setBorder(width: Int, radius: Int, color: UIColor?)
    func removeBorder()
    func setBackgroundColor(color: Color, alpha: Alpha)
    func setBackgroundColor(with color: Color)
    func setBackgroundColor(with alpha: CGFloat)
    func setBackgroundColor(with alpha: Alpha)
    func setAlpha(_ alpha: Alpha)
    func animateScale(_ scale: CGFloat, duration: Double, delay: Double)
}

extension ShapeViewable {
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
    
    func setAlpha(_ alpha: Alpha) {
        self.alpha = alpha.convert(using: CGFloat.self)
    }
    
    func animateScale(_ scale: CGFloat, duration: Double, delay: Double) {
        let originCenter = self.center
        let originSize = self.frame.size
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            let scaledSize = CGSize(width: originSize.width * scale, height: originSize.height * scale)
            self.frame.size = scaledSize
            self.center = originCenter
        }) { done in
            UIView.animate(withDuration: duration, animations: {
                self.frame.size = originSize
                self.center = originCenter
            })
        }
    }
}
