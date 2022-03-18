//
//  Point.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Point {
    
    private(set) var x: Double
    private(set) var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

}

extension Point: CustomStringConvertible {
    var description: String {
        return "x: \(x), y: \(y)"
    }
}
