//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/04.
//

import UIKit

protocol RectangleViewable {
    var frame: CGRect {get set}
    var alpha: CGFloat {get set}
    var backgroundColor: UIColor? {get set}
    var layer: CALayer {get}
    func changeBackgroundColor(to newColor: UIColor)
    func changeAlphaValue(to newAlphaValue: CGFloat)
    func copyToNewInstance() -> UIView & RectangleViewable
    func move(distance: CGPoint)
    func move(to newPoint: CGPoint)
}

class RectangleView: UIView, RectangleViewable {
    
    override var description: String {
        return "Frame = \(frame); alpha = \(alpha); backgroundColor = \(backgroundColor ?? .white)"
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(frame: CGRect, backgroundColor: UIColor, alpha: CGFloat) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    func changeBackgroundColor(to newColor: UIColor) {
        self.backgroundColor = newColor
    }
    
    func changeAlphaValue(to newAlphaValue: CGFloat) {
        self.alpha = newAlphaValue
    }
    
    func copyToNewInstance() -> UIView & RectangleViewable {
        let frame = self.frame
        let alpha = self.alpha
        let backgroundColor = self.backgroundColor ?? UIColor.white
        
        return RectangleView.init(frame: frame, backgroundColor: backgroundColor, alpha: alpha)
    }
    
    func move(distance: CGPoint) {
        self.frame = self.frame.offsetBy(dx: distance.x, dy: distance.y)
    }
    
    func move(to newPoint: CGPoint) {
        self.center.x = newPoint.x
        self.center.y = newPoint.y
    }
}
