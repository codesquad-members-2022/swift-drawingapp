//
//  Plane.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/11.
//

import Foundation

struct Plane {
    private var rectangleArray: Array<Shape> = Array<Rectangle>()
    
    var rectangleCount: Int {
        get {
            return rectangleArray.count
        }
    }
    
    subscript(index: Int) -> Rectangle? {
        if index < rectangleCount, rectangleArray[index] is Rectangle {
            return rectangleArray[index] as? Rectangle
        }
        return nil
    }
    
    mutating func addRectangle(_ rectangle: Shape) {
        if rectangle is Rectangle {
            rectangleArray.append(rectangle)
        }
    }
    
    func isThereARectangle(point: Point) -> Bool {
        for rectangle in rectangleArray {
            if rectangle.isContainPoint(point: point) {
                return true
            }
        }
        return false
    }
}
