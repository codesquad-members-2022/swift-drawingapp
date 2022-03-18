//
//  ShapeViewable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/16.
//

import UIKit

protocol ShapeViewable: UIView {
    func setBorder(width: Int, radius: Int, color: UIColor?)
    func removeBorder()
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
