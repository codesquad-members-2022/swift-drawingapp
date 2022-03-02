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
    let backgroundColor: Color = .white
    let point: Point
    let size: Size
    
    // MARK: - Initializers
    init(id: String, point: Point, size: Size) {
        self.id = id
        self.point = point
        self.size = size
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double) {
        self.id = id
        self.point = Point(x: x, y: y)
        self.size = Size(width: width, height: height)
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return """
        Rect (\(self.id)), \(self.point), \(self.size), \(self.backgroundColor)
        """
    }
}
