//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class Rectangle {
    private let id: String
    private let size: Size
    private let point: Point
    private let backgroundColor: BackgroundColor
    private let alpha: Int
    
    init(id: String, width: Double, height: Double, x: Double, y: Double, backgroundColor: BackgroundColor, alpha: Int) {
        self.id = id
        size = Size(width: width, height: height)
        point = Point(x: x, y: y)
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    init(id: String, size: Size, point: Point, backgroundColor: BackgroundColor, alpha: Int) {
        self.id = id
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }

}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "\(id) Rectangle, \(point), \(size), \(backgroundColor), Alpha: \(alpha)"
    }
}
