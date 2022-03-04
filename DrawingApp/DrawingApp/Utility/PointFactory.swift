//
//  PointFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/04.
//

import Foundation

enum PointFactory: TypeBuilder {
    typealias T = Point
    
    static func makeTypeRandomly() -> Point {
        let range = Point.range
        let x = Double.random(in: range, digits: 2)
        let y = Double.random(in: range, digits: 2)
        
        return Point(x: x, y: y)
    }
}
