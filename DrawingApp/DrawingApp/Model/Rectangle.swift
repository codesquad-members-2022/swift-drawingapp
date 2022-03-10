//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation

class Rectangle: Equatable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs === rhs
    }
    
    private(set) var id: String
    private(set) var point: Point
    private(set) var size: Size
    private(set) var backgroundColor: Color
    private(set) var alpha: Alpha
    
    
    init(id: String, point: Point, size: Size, backgroundColor: Color, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
}


extension Rectangle: CustomStringConvertible {
    var description: String {
        return "(\(id)) \(point), \(size), \(backgroundColor), Alpha: \(alpha)"
    }
}
