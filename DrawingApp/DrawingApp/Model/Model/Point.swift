//
//  Point.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation
import UIKit

struct Point: CustomStringConvertible {
    var x: Double
    var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    init(cgPoint: CGPoint) {
        self.x = cgPoint.x
        self.y = cgPoint.y
    }
    
    var cgPoint: CGPoint {
        CGPoint(x: x, y: y)
    }
    
    var description: String {
        "X:\(x), Y:\(y)"
    }
}
