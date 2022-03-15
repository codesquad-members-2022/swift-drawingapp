//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

class Rectangle: CustomViewEntity{
    private(set) var color: ColorRGB
    
    init(uniqueId: String, color: ColorRGB, point: ViewPoint, size: ViewSize, alpha: Double){
        self.color = color
        super.init(uniqueId: uniqueId, point: point, size: size, alpha: alpha)
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

extension Rectangle: RectangleMutable{    
    func getRandomRectangle() -> Rectangle {
        return self
    }
}
