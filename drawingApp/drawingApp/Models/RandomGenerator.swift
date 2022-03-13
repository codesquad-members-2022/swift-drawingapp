//
//  RandomGenerator.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/11.
//

import Foundation
struct RandomGenerator {
    
    static func makeColor() -> Color {
         let red = Double.random(in: 0..<255)
         let green = Double.random(in: 0..<255)
         let blue = Double.random(in: 0..<255)
         return Color(r: red, g: green, b: blue)
     }
    
    static func makeAlpha() -> Alpha {
        Alpha.allCases.randomElement()!
    }
    
    static func makePoint(minPoint: Point, maxPoint: Point) -> Point {
        let x = Double.random(in: minPoint.x ..< maxPoint.x)
        let y = Double.random(in: minPoint.y ..< maxPoint.y)
        return Point(x: x, y: y)
    }
    
    static func makeId() -> String {
        var UUID = UUID().uuidString.components(separatedBy: "-")
        for i in 1..<4 {
            UUID[i].removeFirst()
        }
        return UUID[1..<4].joined(separator:"-")
    }
}
