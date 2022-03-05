//
//  PointFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

final class PointFactory {
    
    static func makeRandomPoint() -> Point {
        //랜덤으로 생기는 사각형의 Point가 button이나 detailView를 가리지 않도록 빼주었습니다.
        let buttonHight = 300.0
        let detailViewWidth = 350.0
        let randomXpoint = Double.random(in: 0.0...Point.maxX) - detailViewWidth
        let randomYpoint = Double.random(in: 0.0...Point.maxY) - buttonHight
        
        return Point(x: randomXpoint, y: randomYpoint)
    }
    
}
