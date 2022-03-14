//
//  Rectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

final class Rectangle: RectValue, CustomStringConvertible{
    private(set) var color: RGBColor
    
    var description: String{
        let description = "[\(id)] : (X: \(point.x), Y:\(point.y)) / (W: \(size.width), H:\(size.height)) / (R: \(color.red), G: \(color.green), B: \(color.blue)) / Alpha: \(alpha)"
        return description
    }
    
    func changeColor(color: RGBColor){
        self.color = color
    }
    
    init(id: String, size: MySize, point: MyPoint, color: RGBColor, alpha: Alpha){
        self.color = color
        super.init(id: id, size: size, point: point, alpha: alpha)
    }
}
