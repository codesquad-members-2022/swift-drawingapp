//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

class Rectangle: Shapable {
    // MARK: - Properties
    let id: String
    let backgroundColor: Color
    let point: Point
    let size: Size
    let alpha: Alpha
    
    // MARK: - Initializers
    init(id: String, origin: Point, size: Size, color: Color = .white, alpha: Alpha) {
        self.id = id
        self.point = origin
        self.size = size
        self.backgroundColor = color
        self.alpha = alpha
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, color: Color = .white, alpha: Alpha) {
        self.id = id
        self.point = Point(x: x, y: y)
        self.size = Size(width: width, height: height)
        self.backgroundColor = color
        self.alpha = alpha
    }
}

extension Rectangle: Equatable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.id == rhs.id
    }
    
    var description: String {
        return """
        (\(self.id)), \(self.point), \(self.size), \(self.backgroundColor)
        """
    }
}
