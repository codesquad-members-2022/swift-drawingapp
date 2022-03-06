//
//  Point.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

protocol PointBuilder {
    init(x: Double, y: Double)
}

struct Point {
    static let range = 0.0...500.0
    
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
    
    func convert<T: PointBuilder>(using Convertor: T.Type) -> T {
        return Convertor.init(x: self.x, y: self.y)
    }
}

extension Point: CustomStringConvertible, Comparable {
    static func < (lhs: Point, rhs: Point) -> Bool {
        return lhs.x < rhs.x && lhs.y < rhs.y
    }
    
    var description: String {
        return "X: \(self.x), Y: \(self.y)"
    }
}
