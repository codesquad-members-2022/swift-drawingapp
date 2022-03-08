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
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    func addRectangle() {
        rectangles.append(Factory.createRectangle())
    }
    
    func countingRectangle() -> Int {
        if rectangles.isEmpty {
            print("생성된 사각형이 없습니다.")
            return 0
        } else {
            return rectangles.count
        }
    }
    
    func isExist(point: Point) -> Bool {
        for rectangle in rectangles {
            if rectangle.point.x== point.x || rectangle.point.y == point.y {
                return true
            }
            
        }
    }
    
}
