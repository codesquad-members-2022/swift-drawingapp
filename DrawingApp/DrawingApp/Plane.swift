//
//  Plane.swift
//  DrawingApp
//
//  Created by dale on 2022/03/03.
//

import Foundation
class Plane {
    private var rectangles : [Rectangle] = []
    
    var rectangleCount : Int {
        return rectangles.count
    }
    
    func addRectangle(rectangle: Rectangle) {
        self.rectangles.append(rectangle)
    }
    
    func isRectangle(at position : Position) -> Bool {
        return false
    }
}
