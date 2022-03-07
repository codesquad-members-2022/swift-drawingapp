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
    
    var x:Double
    var y:Double
    
    //min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let maxX:Double = 1180.0
    static let maxY:Double = 820.0
    
    static func random() -> Point {
        //랜덤으로 생기는 사각형의 Point가 button이나 detailView를 가리지 않도록 빼주었습니다.
        let buttonHight = 300.0
        let detailViewWidth = 350.0
        let randomXpoint = Double.random(in: 0.0...Point.maxX) - detailViewWidth
        let randomYpoint = Double.random(in: 0.0...Point.maxY) - buttonHight
        
        return Point(x: randomXpoint, y: randomYpoint)
    }
    
    
    init(x:Double,y:Double) {
        self.x = x
        self.y = y
    }
    
}
