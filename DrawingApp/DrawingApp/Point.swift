//
//  Position.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/02.
//

import Foundation

struct Point: CustomStringConvertible{
    
    private var x: Double
    private var y: Double
    
    init(x: Double, y: Double){
        self.x = x
        self.y = y
    }

    static func randomPoint() -> Point {
        let randomX = Double.random(in: 0...900.0)
        let randomY = Double.random(in: 0...650.0)
        return Point(x: randomX, y: randomY)
    }
    
    var description: String {
        return "X : \(x), Y: \(y)"
    }

}
