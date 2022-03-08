//
//  Point.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

import CoreGraphics

struct Point:CustomStringConvertible {
    
    var description: String {
        "X:\(x), Y:\(y)"
    }
    
    var x:Double
    var y:Double
    
    //min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let maxX:Double = 1180.0
    static let maxY:Double = 820.0
    
    static func random() -> Point {
        let randomXpoint = Double.random(in: 0.0...Point.maxX)
        let randomYpoint = Double.random(in: 0.0...Point.maxY)
        return Point(x: randomXpoint, y: randomYpoint)
    }
    
    
    init(x:Double,y:Double) {
        self.x = x
        self.y = y
    }
    
}
