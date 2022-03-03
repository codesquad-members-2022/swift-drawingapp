//
//  Point.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/03.
//

import Foundation

struct Point {
    let x: Double
    let y: Double
    
    static let zero = Point(x: 0, y: 0)
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }
}
