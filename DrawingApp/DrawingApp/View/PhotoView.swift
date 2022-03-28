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
        let newImage = self.image?.copy() as? UIImage ?? UIImage()
        
        return PhotoView.init(frame: self.frame, alpha: self.alpha, image: newImage)
    }
    
    func resize(to newSize: (width: CGFloat, height: CGFloat)) {
        let newFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y,
                              width: newSize.width, height: newSize.height)
        self.frame = newFrame
    }
}

