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
    private var color: RGBColor
    private var alpha: Alpha
    
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
    
    func changeColor(color: RGBColor){
        self.color = color
    }
    
    func changeAlpha(alpha: Double){
        switch alpha{
        case 0.9..<1:
            self.alpha = .nine
        case 0.8..<0.9:
            self.alpha = .eight
        case 0.7..<0.8:
            self.alpha = .seven
        case 0.6..<0.7:
            self.alpha = .six
        case 0.5..<0.6:
            self.alpha = .five
        case 0.4..<0.5:
            self.alpha = .four
        case 0.3..<0.4:
            self.alpha = .three
        case 0.2..<0.3:
            self.alpha = .two
        case 0.0..<0.2:
            self.alpha = .one
        default:
            self.alpha = .ten
        }
    }
    
    init(id: String, size: MySize, point: MyPoint, color: RGBColor, alpha: Alpha){
        self.id = id
        self.size = size
        self.point = point
        self.color = color
        self.alpha = alpha
    }
}
