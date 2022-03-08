//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation

class Rectangle {
    private(set) var id: Id
    private(set) var point: Point
    private(set) var size: Size
    private(set) var backgroundColor: Color
    private(set) var alpha: Alpha
    
    
    init(id: Id, point: Point, size: Size, backgroundColor: Color, alpha: Alpha) {
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
