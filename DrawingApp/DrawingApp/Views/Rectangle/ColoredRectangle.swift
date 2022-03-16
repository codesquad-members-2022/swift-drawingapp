//
//  ColoredRectangle.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/16.
//

import UIKit

final class ColoredRectangle: Rectangle, EnableSetAlphaRectangle {
    
    convenience init(model: ColoredRectangleProperty, index: Int) {
        let origin = CGPoint(x: model.point.x, y: model.point.y)
        let size = CGSize(width: model.size.width, height: model.size.height)
        self.init(frame: CGRect(origin: origin, size: size))
        self.index = index
        
        setBackgroundColor(using: model.rgbValue, alpha: model.alpha)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setBackgroundColor(using color: RectRGBColor, alpha: Double) {
        backgroundColor = color.getColor(alpha: alpha)
    }
    
    func setValue(alpha: CGFloat) {
        backgroundColor = backgroundColor?.withAlphaComponent(alpha/10)
    }
}
