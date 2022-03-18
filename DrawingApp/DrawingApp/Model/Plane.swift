//
//  Plane.swift
//  DrawingApp
//
//  Created by 허태양 on 2022/03/16.
//

import Foundation

struct Plane {
    var square: [Square] = []
    mutating func addSquare(square: Square) {
        self.square.append(square)
    }
    
    var totalSquareCount: Int {
        get {
            return self.square.count
        }
    }

    subscript(index: Int) -> Square {
        return square[index]
    }

    subscript(position: Point) -> Square? {
        for s in self.square.reversed() {
            if s.isPointIncluded(position: position) == true {
                return s
            }
        }
        return nil
    }
}
