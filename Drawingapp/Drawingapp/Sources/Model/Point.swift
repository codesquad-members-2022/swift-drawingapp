//
//  Point.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

struct Point: CustomStringConvertible {
    let x: Double
    let y: Double
    
    var description: String {
        "X: \(x), Y: \(y)"
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }
}
