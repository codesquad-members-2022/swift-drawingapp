//
//  Plane.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
import OSLog

protocol PlaneDelegate {
    func didAppendRect(rect: Rectangle?)
}

struct Plane{
    
    var delegate : PlaneDelegate?
    
    
    private var rectangles = [Rectangle]() {
        willSet{
            os_log(.debug, "Plane 에 있는 사각형 정보 : \(newValue)")
            delegate?.didAppendRect(rect: newValue.last)
        }
    }
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
                os_log(.debug,"모델정보: \(rectangle)")
                return rectangle
            }
        }
        return nil
    }
    
 
}
