//
//  Point.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

struct Point {
    let x: Double
    let y: Double
    
    init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point: CustomStringConvertible, Equatable {
    var description: String {
        return "X: \(self.x), Y: \(self.y)"
    }
}
