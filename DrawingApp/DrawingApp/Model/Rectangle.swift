//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

class Rectangle {
    // MARK: - Properties
    let id: String
    let backgroundColor: Color
    let point: Point
    let size: Size
    
    // MARK: - Initializers
    init(id: String, point: Point, size: Size, color: Color = .white) {
        self.id = id
        self.point = point
        self.size = size
        self.backgroundColor = color
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, color: Color = .white) {
        self.id = id
        self.point = Point(x: x, y: y)
        self.size = Size(width: width, height: height)
        self.backgroundColor = color
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return """
        (\(self.id)), \(self.point), \(self.size), \(self.backgroundColor)
        """
    }
}
