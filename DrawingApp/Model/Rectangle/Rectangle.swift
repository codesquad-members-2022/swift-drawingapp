//
//  Rectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

final class Rectangle: CustomStringConvertible{
    private let id: String
    private let size: MySize
    private let point: MyPoint
    private let color: RGBColor
    private let alpha: Alpha
    
    var description: String{
        let description = "[\(id)] : (X: \(point.xValue()), Y:\(point.yValue())) / (W: \(size.widthValue()), H:\(size.heightValue())) / (R: \(color.redValue()), G: \(color.greenValue()), B: \(color.blueValue())) / Alpha: \(showAlpha())"
        return description
    }
    
    func showId() -> String{
        return id
    }
    
    func showSize() -> MySize{
        return size
    }
    
    func showPoint() -> MyPoint{
        return point
    }
    
    func showColor() -> RGBColor{
        return color
    }
    
    func showAlpha() -> Alpha{
        return alpha
    }
    
    init(id: String, size: MySize, point: MyPoint, color: RGBColor, alpha: Alpha){
        self.id = id
        self.size = size
        self.point = point
        self.color = color
        self.alpha = alpha
    }
}
