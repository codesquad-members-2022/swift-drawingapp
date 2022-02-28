//
//  Position.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Position {
    private var x : Double
    private var y : Double
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
