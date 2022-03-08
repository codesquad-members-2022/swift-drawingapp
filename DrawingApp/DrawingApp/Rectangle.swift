//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class Rectangle: Shape {
    let id: String

    var size: Size
    
    var point: Point
    
    var backgroundColor: BackgroundColor
    
    var alpha: Int
    
    required init(id: String, point: Point, size: Size, backgroundColor: BackgroundColor, alpha: Int) {
        self.id = id
        self.point = point
        self.size = size
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "Rectangle(\(self.id)) : \(self.point), \(self.size), \(self.backgroundColor), \(self.alpha)"
    }
}
