//
//  Point.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/29.
//

import Foundation

class Point {
    private(set) var x:Double
    private(set) var y:Double
    
    init(x: Double, y:Double) {
        self.x = x
        self.y = y
    }
    
    static func randomPoint() -> Point {
        let randomX = Double.random(in: 0.0...900.0)
        let randomY  = Double.random(in: 0.0...650.0)
        return Point(x: randomX, y: randomY)
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "X: \(self.x), Y:\(self.y)"
    }
}

