//
//  Rectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

final class Rectangle: CustomStringConvertible{
    let id: String
    let size: MySize
    let point: MyPoint
    private var color: RGBColor
    private var alpha: Alpha
    
    var description: String{
        let description = "[\(id)] : (X: \(point.x), Y:\(point.y)) / (W: \(size.width), H:\(size.height)) / (R: \(color.red), G: \(color.green), B: \(color.blue)) / Alpha: \(showAlpha())"
        return description
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
    
    func changeAlpha(alpha: Alpha){
        self.alpha = alpha
    }
    
    func findLocationRange(xPoint: Double, yPoint: Double) -> Rectangle?{
        let minX: Double = self.point.x
        let maxX: Double = minX + self.size.width
        let minY: Double = self.point.y
        let maxY: Double = minY + self.size.height
        
        if xPoint >= minX, xPoint <= maxX, yPoint >= minY, yPoint <= maxY{
            return self
        } else{
            return nil
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
