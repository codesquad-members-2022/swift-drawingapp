//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Rectangle {
    
    private let id: String
    private(set) var size: Size
    private(set) var point: Point
    private(set) var color: Color
    private(set) var alpha: Alpha
    
    init(id: String, size: Size, point: Point, color: Color, alpha: Alpha) {
        self.id = id
        self.size = size
        self.point = point
        self.color = color
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(size), \(point), \(color), \(alpha)"
    }
}

extension Rectangle: Equatable, Hashable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
