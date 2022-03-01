//
//  Point.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class Point:CustomStringConvertible {
    var description: String {
        "X:\(x), Y:\(y)"
    }
    
    private var x:Double
    private var y:Double
    
    init(x:Double,y:Double) {
        self.x = x
        self.y = y
    }
    
}
