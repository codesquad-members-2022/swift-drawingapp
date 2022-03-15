//
//  RandomRectangleFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation

class RandomRectangleFactory {
    
    static func generateRandomIdentifier() -> Identifier {
        return Identifier()
    }
    
    static func generateRandomPoint(xBound: Double, yBound: Double) -> Point {
        let randomX = round(Double.random(in: Point.Range.lower...xBound))
        let randomY = round(Double.random(in: Point.Range.lower...yBound))
        
        return Point(x: randomX, y: randomY)
    }
    
    static func generateRandomColor() -> Color {
        let validRange = (Color.Range.lower...Color.Range.upper)
        
        let randomRed = round(Double.random(in: validRange))
        let randomGreen = round(Double.random(in: validRange))
        let randomBlue = round(Double.random(in: validRange))
        
        return Color(validRed: randomRed, validGreen: randomGreen, validBlue: randomBlue)
    }
    
    static func createRandomRectangle(xBound: Double, yBound: Double) -> Rectangle {
        return Rectangle(identifier: generateRandomIdentifier(),
                         point: generateRandomPoint(xBound: xBound, yBound: yBound),
                         size: Size(width: Size.Range.width, height: Size.Range.height),
                         backgroundColor: generateRandomColor(),
                         alpha: Alpha.random)
    }
}
