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
    
    func changeBackgroundColor(to newColor: UIColor) {
        self.backgroundColor = newColor
    }
    
    func changeAlphaValue(to newAlphaValue: CGFloat) {
        self.alpha = newAlphaValue
    }
}
