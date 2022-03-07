//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class Rectangle {
    private(set) var id: ID
    private(set) var size: Size
    private(set) var point: Point
    private(set) var backgroundColor: BackgroundColor
    private(set) var alpha: Alpha
    
    init(id: ID, width: Double, height: Double, x: Double, y: Double, backgroundColor: BackgroundColor, alpha: Alpha) {
        self.id = id
        size = Size(width: width, height: height)
        point = Point(x: x, y: y)
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    init(id: ID, size: Size, point: Point, backgroundColor: BackgroundColor, alpha: Alpha) {
        self.id = id
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    func isPointInArea(_ point: Point) -> Bool {
        if point.x >= self.point.x && point.x <= self.point.x + self.size.width &&
            point.y >= self.point.y && point.y <= self.point.y + self.size.height {
            return true
        }
        return false
    }
    
    func changeBackgroundColor(to newColor: BackgroundColor) {
        self.backgroundColor = newColor
    }
    
    func changeAlphaValue(to newAlpha: Alpha) {
        self.alpha = newAlpha
    }

}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "\(id) Rectangle, \(point), \(size), \(backgroundColor), \(alpha)"
    }
}

extension Rectangle: Equatable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.id == rhs.id
    }
}
