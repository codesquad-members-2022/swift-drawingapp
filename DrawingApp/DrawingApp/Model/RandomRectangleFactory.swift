//
//  RandomRectangleFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation

class RandomRectangleFactory {
    
    func generateRandomIdentifier() -> Identifier {
        return Identifier()
    }
    
    func generateRandomSize() -> Size {
        let validRange = (Size.Range.lower...Size.Range.upper)
        
        let randomWidth = round(Double.random(in: validRange))
        let randomHeight = round(Double.random(in: validRange))
        
        return Size(width: randomWidth, height: randomHeight)
    }
    
    func generateRandomPoint() -> Point {
        let validRange = (Point.Range.lower...Point.Range.upper)
        
        let randomX = round(Double.random(in: validRange))
        let randomY = round(Double.random(in: validRange))
        
        return Point(x: randomX, y: randomY)
    }
    
    func generateRandomColor() -> Color {
        let validRange = (Color.Range.lower...Color.Range.upper)
        
        let randomRed = round(Double.random(in: validRange))
        let randomGreen = round(Double.random(in: validRange))
        let randomBlue = round(Double.random(in: validRange))
        
        return Color(validRed: randomRed, validGreen: randomGreen, validBlue: randomBlue)
    }
    
    func createRandomShape() -> Rectangle {
        return Rectangle(identifier: generateRandomIdentifier(),
                         size: generateRandomSize(),
                         point: generateRandomPoint(),
                         backGroundColor: generateRandomColor(),
                         alpha: Alpha.random)
    }
}
