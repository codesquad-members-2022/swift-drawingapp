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
        let id = generateRandomID()
        
        let newRectangle = Rectangle(id: id, size: size, point: point, backgroundColor: backgroundColor, alpha: alpha)
        
        delegate?.factoryDidGenerateRandomRectangle(newRectangle)
        
        return newRectangle
    }
    
    private static func generateRandomPoint(in frame: (width: Double, height: Double)) -> Point {
        let maxXPoint = frame.width
        let maxYPoint = frame.height
        
        return Point(x: Double.random(in: 0...maxXPoint),
                                y: Double.random(in: 0...maxYPoint))
    }
    
    private static func generateRandomColor() -> BackgroundColor {
        let minimumColorValue = 0
        let maximumColorValue = 255
        
        let red = (minimumColorValue...maximumColorValue).randomElement() ?? minimumColorValue
        let green = (minimumColorValue...maximumColorValue).randomElement() ?? minimumColorValue
        let blue = (minimumColorValue...maximumColorValue).randomElement() ?? minimumColorValue

        return BackgroundColor(r: red, g: green, b: blue,
                               min: minimumColorValue, max: maximumColorValue)
    }
    
    private static func generateRandomAlpha() -> Alpha {
        let minimumOpacityLevel = 1
        let maximumOpacityLevel = 10
        
        return Alpha(opacityLevel: (minimumOpacityLevel...maximumOpacityLevel).randomElement() ?? minimumOpacityLevel,
                     min: minimumOpacityLevel, max: maximumOpacityLevel)
    }
    
    private static func generateRandomID() -> ID {
        func generateRandomString(length: Int) -> String {
            return String(NSUUID().uuidString.prefix(length))
        }
        
        let randomIDParts = [generateRandomString(length: 3), generateRandomString(length: 3), generateRandomString(length: 3)]
        return ID.init(with: randomIDParts.joined(separator: "-")) ?? nil
    }
    
}
