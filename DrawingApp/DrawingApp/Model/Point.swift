//
//  Point.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

struct Point: PointBuildable {
    static let range = 0.0...500.0
    
    let x: Double
    let y: Double
    
    init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }
    
    init(x: Double, y: Double) {
        self.x = x.toFixed(digits: 4)
        self.y = y.toFixed(digits: 4)
    }
    
    func convert<T: PointBuildable>(using Convertor: T.Type) -> T {
        return Convertor.init(x: self.x, y: self.y)
    }
}

extension Point: CustomStringConvertible, Comparable {
    static func < (lhs: Point, rhs: Point) -> Bool {
        
        if lhs.x == rhs.x {
            return lhs.y < rhs.y
        }
        
        if lhs.y == rhs.y {
            return lhs.x < rhs.x
        }
        
        return (lhs.x < rhs.x) && (lhs.y < rhs.y)
    }
    
    static func <= (lhs: Point, rhs: Point) -> Bool {
        return lhs.x <= rhs.x && lhs.y <= rhs.y
    }
    
    var description: String {
        return "X: \(self.x), Y: \(self.y)"
    }
}
