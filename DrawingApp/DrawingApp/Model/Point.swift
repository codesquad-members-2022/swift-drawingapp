//
//  Point.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct Point: Equatable {
    let x: Double
    let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    static func random(in frame: (width: Double, height: Double)) -> Point {
        let maxXPoint = frame.width
        let maxYPoint = frame.height
        
        return Point(x: Double.random(in: 0...maxXPoint),
                     y: Double.random(in: 0...maxYPoint))
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y))"
    }
}
