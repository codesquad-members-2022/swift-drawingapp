//
//  Position.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Position {
    var x : Double
    var y : Double
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Position: CustomStringConvertible {
    var description: String {
        return "x:\(x), y:\(y)"
    }
}
