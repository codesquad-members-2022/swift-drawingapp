//
//  PointFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/06.
//

import Foundation

class PointFactory {
    public static func generateRandomPoint(in frame: (width: Double, height: Double)) -> Point {
        let maxXPoint = frame.width
        let maxYPoint = frame.height
        
        return Point(x: Double.random(in: 0...maxXPoint),
                     y: Double.random(in: 0...maxYPoint))
    }
}
