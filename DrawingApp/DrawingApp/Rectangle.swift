//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class Rectangle {
    private let id: String
    private var size: Size
    private var point: Point
    private var backgroundColor: BackgroundColor
    
    init(id: String, width: Double, height: Double, x: Double, y: Double, backgroundColor: BackgroundColor) {
        self.id = id
        size = Size(width: width, height: height)
        point = Point(x: x, y: y)
        self.backgroundColor = backgroundColor
    }
    
    init(id: String, size: Size, point: Point, backgroundColor: BackgroundColor) {
        self.id = id
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
    }

}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "\(id) Rectangle, \(point), \(size), \(backgroundColor)"
    }
}
