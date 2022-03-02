//
//  Square.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation

protocol ViewModel {
    var center: Point { get }
    func contains(_ point: Point) -> Bool
}

protocol ColorMutable {
    func transform(to color: Color)
}

protocol AlphaMutable {
    func transform(to alpha: Alpha)
}

class Rectangle: ViewModel {
    private var id: String
    private var origin: Point
    private var size: Size
    private var color: Color
    private var alpha: Alpha
    
    init(id: String, origin: Point, size: Size, color: Color, alpha: Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.color = color
        self.alpha = alpha
    }
    
    var center: Point {
        Point(x: origin.x + (size.width / 2),
              y: origin.y + (size.height / 2))
    }
    
    func contains(_ point: Point) -> Bool {
        return (origin.x...origin.x+size.width).contains(point.x)
        && (origin.y...origin.y+size.height).contains(point.y)
    }
}

extension Rectangle: ColorMutable {
    func transform(to color: Color) {
        self.color = color
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(origin), \(size), \(color), \(alpha)"
    }
}
