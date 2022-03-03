//
//  Plane.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation

struct Plane {
    private var rectangles = [Rectangle]()
    var numberOfRect : Int {
        self.rectangles.count
    }
    subscript(index: Int) -> Rectangle?{
        get {
            guard numberOfRect > index else {
                return nil
            }
            return rectangles[index]
        }
    }
    
    mutating func append(_ rect : Rectangle) {
        self.rectangles.append(rect)
    }
    
    func detectRect(x: Double, y: Double) -> Rectangle? {
        for rectangle in rectangles {
            let minX = rectangle.point.x
            let minY = rectangle.point.y
            let maxX = rectangle.point.x + rectangle.size.width
            let maxY = rectangle.point.y + rectangle.size.height
            
            if minX <= x, maxX >= x, minY <= y , maxY >= y {
                return rectangle
            }
        }
        
        return nil
    }
    
}
