//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/04.
//

import UIKit

protocol RectangleViewable: NSCopying {
    var alpha: CGFloat {get}
    func hideBoundary()
    func showBoundary()
    func changeBackgroundColor(to newColor: UIColor)
    func changeAlphaValue(to newAlphaValue: CGFloat)
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
    
    func hideBoundary() {
        self.layer.borderWidth = 0
    }
    
    func showBoundary() {
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func changeBackgroundColor(to newColor: UIColor) {
        self.backgroundColor = newColor
    }
    
    func changeAlphaValue(to newAlphaValue: CGFloat) {
        self.alpha = newAlphaValue
    }
    
    func move(distance: CGPoint) {
        self.frame = self.frame.offsetBy(dx: distance.x, dy: distance.y)
    }
    
    func move(to newPoint: CGPoint) {
        self.frame.origin.x = newPoint.x
        self.frame.origin.y = newPoint.y
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let newFrame = self.frame.copy()
        let newBackgroundColor = self.backgroundColor?.copy() as? UIColor ?? UIColor.white
        let newAlpha = self.alpha.copy()
        
        return RectangleView.init(frame: newFrame, backgroundColor: newBackgroundColor, alpha: newAlpha)
    }
}

extension CGRect {
    fileprivate func copy() -> CGRect {
        return CGRect(x: self.minX, y: self.minY, width: self.width, height: self.height)
    }
}

extension CGFloat {
    fileprivate func copy() -> CGFloat {
        return CGFloat(self)
    }
}
