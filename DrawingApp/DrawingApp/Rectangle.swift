//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

class Rectangle{
    private var uniqueId: String
    private var color: RectangleColor
    private var point: ViewPoint
    
    init(uniqueId: String, color: RectangleColor, point: ViewPoint){
        self.uniqueId = uniqueId
        self.color = color
        self.point = point
    }
}

extension Rectangle: CustomStringConvertible{
    var description: String {
        return "(\(uniqueId)) \(point.description) \(color.description)"
    }
}
