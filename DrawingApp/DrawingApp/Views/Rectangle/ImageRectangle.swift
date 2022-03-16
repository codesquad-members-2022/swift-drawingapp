//
//  ImageRectangle.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/16.
//

import UIKit

final class ImageRectangle: Rectangle, EnableSetAlphaRectangle {
    
    private let imageView = UIImageView()
    
    convenience init(model: ImageRectangleProperty, index: Int) {
        let origin = CGPoint(x: model.point.x, y: model.point.y)
        let size = CGSize(width: model.size.width, height: model.size.height)
        self.init(frame: CGRect(origin: origin, size: size))
        
        self.index = index
        
        imageView.frame = self.bounds
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(data: model.imageData)
        imageView.alpha = model.alpha/10
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setValue(alpha: CGFloat) {
        imageView.alpha = alpha/10
    }
    
    func getImage() -> UIImage? {
        imageView.image
    }
}
