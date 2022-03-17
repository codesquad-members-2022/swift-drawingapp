//
//  Plane.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/08.
//

import Foundation

class Plane {
    
    private var rectangles: [Rectangle] = []
    private var selctRectangle: Rectangle?
    var delegate: PlaneDelegate?
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    func createRectangle() {
        let add = Factory.createRectangle()
        rectangles.append(add)
        
        delegate?.didCreatRectangel(rectangle: add)
    }
    
    func countingRectangle() -> Int {
        if rectangles.isEmpty {
            print("생성된 사각형이 없습니다.")
            return 0
        } else {
            return rectangles.count
        }
    }
    
    func isExist(point: Point) -> Rectangle? {
        for rectangle in rectangles {
            if rectangle.point.x == point.x || rectangle.point.y == point.y {
                selctRectangle = rectangle
                return selctRectangle
            }
        }
        return nil
    }
    
}
