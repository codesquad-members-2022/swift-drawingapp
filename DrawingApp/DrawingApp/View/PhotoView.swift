//
//  PhotoView.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/14.
//

import UIKit

class PhotoView: UIImageView, RectangleViewable {
    
    init(frame: CGRect, alpha: CGFloat, image: UIImage) {
        super.init(frame: frame)
        self.alpha = alpha
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.alpha = 1.0
        self.image = UIImage()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 1.0
        self.image = UIImage()
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
        self.center.x = newPoint.x
        self.center.y = newPoint.y
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let newFrame = self.frame.copy()
        let newImage = self.image?.copy() as? UIImage ?? UIImage()
        let newAlpha = self.alpha.copy()
        
        return PhotoView.init(frame: newFrame, alpha: newAlpha, image: newImage)
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

