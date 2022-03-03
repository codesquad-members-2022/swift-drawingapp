//
//  PointFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

final class PointFactory {
    
    static func makeRandomPoint() -> Point {
        let randomXpoint = Double.random(in: 0.0...Point.maxX)
        let randomYpoint = Double.random(in: 0.0...Point.maxY)
        
        return Point(x: randomXpoint, y: randomYpoint)
    }
    
}
