//
//  Point.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

struct Point {
    private var x: Double
    private var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point {
    enum Bound {
        static let lowwer = 0.0
        static let upper = 100.0
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "X: \(self.x), Y: \(self.y)"
    }
}
