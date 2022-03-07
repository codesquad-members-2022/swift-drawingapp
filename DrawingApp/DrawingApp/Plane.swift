//
//  Plane.swift
//  DrawingApp
//
//  Created by dale on 2022/03/03.
//

import Foundation
class Plane {
    var rectangles : [Rectangle] = []
    subscript(index: Int) -> Rectangle? {
        if index < rectangleCount {
            let targetRectangle = rectangles[index]
            return targetRectangle
        }
        return nil
    }
    
    var rectangleCount : Int {
        return rectangles.count
    }
    
    func addRectangle(rectangle: Rectangle) {
        self.rectangles.append(rectangle)
    }
    
    func searchRectangle(at position : Position) -> Rectangle? {
        for rectangle in rectangles {
            if (rectangle.position.x...(rectangle.position.x + rectangle.size.width)).contains(position.x) && (rectangle.position.y...(rectangle.position.y + rectangle.size.height)).contains(position.y) {
                return rectangle
            }
        }
        return nil
    }
}
