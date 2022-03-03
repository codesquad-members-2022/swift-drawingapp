//
//  Square.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation
import UIKit

protocol ViewModel {
    var center: Point { get }
    var cgRect: CGRect { get }
    func contains(_ point: Point) -> Bool
}

protocol ColorMutable {
    var uiColor: UIColor { get }
    func transform(to color: Color)
}

protocol AlphaMutable {
    var cgAlpha: CGFloat { get }
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
    
    var cgRect: CGRect {
        CGRect(origin: origin.cgPoint, size: size.cgSize)
    }
    
    func contains(_ point: Point) -> Bool {
        return (origin.x...origin.x+size.width).contains(point.x)
        && (origin.y...origin.y+size.height).contains(point.y)
    }
}

extension Rectangle: ColorMutable {
    var uiColor: UIColor {
        color.uiColor
    }
    
    func transform(to color: Color) {
        self.color = color
    }
}

extension Rectangle: AlphaMutable {
    var cgAlpha: CGFloat {
        CGFloat(alpha.value)
    }
    
    func transform(to alpha: Alpha) {
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(origin), \(size), \(color), \(alpha)"
    }
}
