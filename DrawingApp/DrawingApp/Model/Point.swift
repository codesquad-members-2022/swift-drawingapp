//
//  Point.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

struct Point {
    private let x: Double
    private let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func getX() -> Double {
        return x
    }
    
    func getY() -> Double {
        return y
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "X:\(self.x), Y:\(self.y)"
    }
}
