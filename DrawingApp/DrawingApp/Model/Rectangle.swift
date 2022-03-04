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
    let size: Size
    let alpha: Alpha
    let origin: Point
    
    // MARK: - Initializers
    init(id: String, origin: Point, size: Size, color: Color = .white, alpha: Alpha = .opaque) {
        self.id = id
        self.origin = origin
        self.size = size
        self.backgroundColor = color
        self.alpha = alpha
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, color: Color = .white, alpha: Alpha = .opaque) {
        self.id = id
        self.origin = Point(x: x, y: y)
        self.size = Size(width: width, height: height)
        self.backgroundColor = color
        self.alpha = alpha
    }
    
    func contains(point: Point) -> Bool {
        let maxX = self.origin.x + self.size.width
        let maxY = self.origin.y + self.size.height
        return point >= self.origin && point <= Point(x: maxX, y: maxY)
    }
}

extension Rectangle: Equatable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.id == rhs.id
    }
    
    var description: String {
        return """
        (\(self.id)), \(self.origin), \(self.size), \(self.backgroundColor)
        """
    }
}
