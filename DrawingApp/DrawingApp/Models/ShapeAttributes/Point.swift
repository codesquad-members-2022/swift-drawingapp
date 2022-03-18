//
//  Point.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import UIKit

struct Point {
    
    private(set) var x: Double
    private(set) var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func toCGPoint() -> CGPoint {
        return CGPoint(x: x, y: y)
    }
}

extension Point {
    enum Range {
        static let lower = 0.0
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "X: \(self.x), Y: \(self.y)"
    }
}
