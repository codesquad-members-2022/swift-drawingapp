//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

class Rectangle {
    // MARK: - Properties
    private let id: String
    
    var backgroundColor: Color = .white
    var alpha: Alpha = .ten
    var point: Point
    var size: Size
    
    // MARK: - Initializers
    init(id: String, point: Point, size: Size) {
        self.id = id
        self.point = point
        self.size = size
    }
    
    convenience init(id: String, x: Double, y: Double, width: Double, height: Double) {
        let point = Point(x: x, y: y)
        let size = Size(width: width, height: height)
        self.init(id: id, point: point, size: size)
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return """
        Rect (\(self.id)), \(self.point.x), \(self.size.height), \(self.backgroundColor), \(self.alpha)
        """
    }
}
