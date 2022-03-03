//
//  Point.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

struct Point:CustomStringConvertible {
    
    var description: String {
        "X:\(x), Y:\(y)"
    }
    
    private var x:Double
    private var y:Double
    
    //min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let maxX:Double = 820.0
    static let maxY:Double = 1180.0
    
    
    init(x:Double,y:Double) {
        self.x = x
        self.y = y
    }
    
}
