//
//  Plane.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/03.
//

import Foundation

class Plane {
    private var rectangles = [Rectangle]()
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    public func isRectangleExist(in point: Point) -> Bool {
        return rectangles.filter { rectangle in
            rectangle.hasSamePoint(point)
        }.count != 0
    }
    
    public func add(rectangle: Rectangle) {
        rectangles.append(rectangle)
    }
}
