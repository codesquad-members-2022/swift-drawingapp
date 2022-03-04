//
//  Point.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation

class Point {
    private let x: Double
    private let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}


extension Point: CustomStringConvertible {
    var description: String {
        return "X:\(x), Y:\(y)"
    }
}
