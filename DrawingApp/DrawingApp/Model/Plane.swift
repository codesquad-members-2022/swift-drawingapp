//
//  Plane.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/08.
//

import Foundation
import UIKit

class Plane {
    
    private var rectangles: [Rectangle] = []
    private var selctRectangle: Rectangle?
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    func addRectangle() -> Rectangle {
        let add = Factory.createRectangle()
        rectangles.append(add)
        return add
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
