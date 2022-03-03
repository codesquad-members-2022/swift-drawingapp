//
//  Square.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation

protocol ViewModel {
    var id: String { get }
    var center: Point { get }
    var origin: Point { get }
    var size: Size { get }
    func contains(_ point: Point) -> Bool
}

protocol ColorMutable {
    var color: Color { get }
    func transform(to color: Color)
}

protocol AlphaMutable {
    var alpha: Alpha { get }
    func transform(to alpha: Alpha)
}

class Rectangle: ViewModel {
    private(set) var id: String
    private(set) var origin: Point
    private(set) var size: Size
    private(set) var color: Color
    private(set) var alpha: Alpha
    
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
//
//    var cgRect: CGRect {
//        Converter.toCGRect(origin: <#T##Point#>, size: <#T##Size#>)
//    }
//
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

extension Rectangle: AlphaMutable {
    func transform(to alpha: Alpha) {
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(origin), \(size), \(color), \(alpha)"
    }
}
