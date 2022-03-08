//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

class Rectangle: NSObject{
    private(set) var uniqueId: String
    private(set) var color: ColorRGB
    private(set) var point: ViewPoint
    private(set) var size: ViewSize
    private(set) var alpha: Double
    override var description: String {
        return "(\(uniqueId)) \(point.description),\(size.description) \(color.description) alpha:\(alpha)"
    }
    
    init(uniqueId: String, color: ColorRGB, point: ViewPoint, size: ViewSize, alpha: Double){
        self.uniqueId = uniqueId
        self.color = color
        self.point = point
        self.size = size
        self.alpha = alpha
    }
    
    func changeAlphaValue(alpha: Double){
        self.alpha = alpha
    }
    
    func resetColor(rgbValue: ColorRGB){
        self.color = rgbValue
    }
}
