//
//  PointFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

final class PointFactory {
    
    static func makeRandomPoint() -> Point {
        //랜덤으로 생기는 사각형의 Point가 사각형 추가버튼을 가리지 않도록 하기위해 buttonHeight만큼 y좌표를 뺐다.
        let buttonHight = 200.0
        let randomXpoint = Double.random(in: 0.0...Point.maxX)
        let randomYpoint = Double.random(in: 0.0...Point.maxY) - buttonHight
        
        return Point(x: randomXpoint, y: randomYpoint)
    }
    
}
