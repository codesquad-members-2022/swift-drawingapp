//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class RectangleFactory {
    
    public static func generateRandomRectangle(in frame: (Double, Double)) -> Rectangle {
        let size = Size(width: 150, height: 120)
        let point = generateRandomPoint(in: frame)
        let backgroundColor = generateRandomColor()
        let alpha = generateRandomAlpha()
        let id = ID()
        
        let newRectangle = Rectangle(id: id, size: size, point: point, backgroundColor: backgroundColor, alpha: alpha)
        return newRectangle
    }
    
    private static func generateRandomPoint(in frame: (width: Double, height: Double)) -> Point {
        let maxXPoint = frame.width
        let maxYPoint = frame.height
        
        return Point(x: Double.random(in: 0...maxXPoint),
                                y: Double.random(in: 0...maxYPoint))
    }
    
    private static func generateRandomColor() -> BackgroundColor {
        
        let red = BackgroundColor.possibleColorValues.randomElement() ?? 0
        let green = BackgroundColor.possibleColorValues.randomElement() ?? 0
        let blue = BackgroundColor.possibleColorValues.randomElement() ?? 0

        return BackgroundColor(r: red, g: green, b: blue)
    }
    
    private static func generateRandomAlpha() -> Alpha {
        let randomOpacityLevel = Alpha.possibleOpacityLevels.randomElement() ?? 10
        return Alpha(opacityLevel: randomOpacityLevel)
    }
    
}
