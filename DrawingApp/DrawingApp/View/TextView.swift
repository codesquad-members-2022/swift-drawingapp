//
//  TextView.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/29.
//

import UIKit

class TextView: UILabel, RectangleViewable {
    
    init(frame: CGRect, alpha: CGFloat, text: String) {
        super.init(frame: frame)
        self.alpha = alpha
        self.text = text
        self.font = UIFont(name: "Helvetica", size: 20)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.alpha = 1.0
        self.text = " "
    }
    
    func changeAlphaValue(to newAlphaValue: CGFloat) {
        self.alpha = newAlphaValue
    }
    
    func hideBoundary() {
        self.layer.borderWidth = 0
    }
    
    func showBoundary() {
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func move(distance: CGPoint) {
        self.frame = self.frame.offsetBy(dx: distance.x, dy: distance.y)
    }
    
    func move(to newPoint: CGPoint) {
        self.frame.origin.x = newPoint.x
        self.frame.origin.y = newPoint.y
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return TextView.init(frame: self.frame, alpha: self.alpha, text: self.text ?? " ")
    }
    
    func resize(to newSize: (width: CGFloat, height: CGFloat)) {
        let newFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y,
                              width: newSize.width, height: newSize.height)
        self.frame = newFrame
    }
}
