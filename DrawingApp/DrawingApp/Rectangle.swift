//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

class Rectangle{
    private var uniqueId: String
    private var color: ColorRGB
    private var point: ViewPoint
    private var size: ViewSize
    private var alpha: Double
    
    init(uniqueId: String, color: ColorRGB, point: ViewPoint, size: ViewSize, alpha: Double){
        self.uniqueId = uniqueId
        self.color = color
        self.point = point
        self.size = size
        self.alpha = alpha
    }

    func idValue() -> String{
        return self.uniqueId
    }
    
    func colorValue() -> ColorRGB{
        return color
    }
    
    func pointValue() -> ViewPoint{
        return point
    }
    
    func sizeValue() -> ViewSize{
        return size
    }
    
    func alphaValue() -> Double{
        return alpha
    }
    
    func changeAlphaValue(alpha: Double){
        self.alpha = alpha
    }
    
    func resetColor(rgbValue: ColorRGB){
        self.color = rgbValue
    }
}

extension Rectangle: CustomStringConvertible{
    var description: String {
        return "(\(uniqueId)) \(point.description),\(size.description) \(color.description) alpha:\(alpha)"
    }
}
