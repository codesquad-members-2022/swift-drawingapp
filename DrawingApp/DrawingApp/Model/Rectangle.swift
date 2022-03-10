//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class Rectangle: Shape {
    private let id: String

    private var size: Size
    
    private var point: Point
    
    private var color: Color
    
    private var alpha: Alpha
    
    init(id: String, point: Point, size: Size, color: Color, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "Rectangle(\(self.id)) : \(self.point), \(self.size), \(self.color), \(self.alpha)"
    }
}
