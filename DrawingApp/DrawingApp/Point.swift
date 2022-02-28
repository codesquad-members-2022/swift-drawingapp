//
//  Point.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct Point {
    private var xPosition: Double
    private var yPosition: Double
    
    init(x: Double, y: Double) {
        xPosition = x
        yPosition = y
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "(\(xPosition), \(yPosition))"
    }
}
