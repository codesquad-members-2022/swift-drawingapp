//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation

class RectangleFactory {

    func createRactangle(identifier: Identifier,
                         size: Size,
                         point: Point,
                         color: Color,
                         alpha: Alpha) -> Rectangle {
        
        return Rectangle(identifier: identifier,
                         size: size,
                         point: point,
                         backGroundColor: color,
                         alpha: alpha)
    }
}

extension RectangleFactory: RandomRectangleFactorable {
    
    func generateRandomIdentifier() -> Identifier {
        return Identifier()
    }
    
    func generateRandomSize() -> Size {
        let validRange = (Size.Bound.lowwer...Size.Bound.upper)
        
        let randomWidth = round(Double.random(in: validRange))
        let randomHeight = round(Double.random(in: validRange))
        
        return Size(width: randomWidth, height: randomHeight)
    }
    
    func generateRandomPoint() -> Point {
        let validRange = (Point.Bound.lowwer...Point.Bound.upper)
        
        let randomX = round(Double.random(in: validRange))
        let randomY = round(Double.random(in: validRange))
        
        return Point(x: randomX, y: randomY)
    }
    
    func generateRandomColor() -> Color {
        let validRange = (Color.Bound.lowwer...Color.Bound.upper)
        
        let randomRed = round(Double.random(in: validRange))
        let randomGreen = round(Double.random(in: validRange))
        let randomBlue = round(Double.random(in: validRange))
        
        return Color(validRed: randomRed, validGreen: randomGreen, validBlue: randomBlue)
    }
    
    func createRandomShape() -> Shapable {
        return Rectangle(identifier: generateRandomIdentifier(),
                         size: generateRandomSize(),
                         point: generateRandomPoint(),
                         backGroundColor: generateRandomColor(),
                         alpha: Alpha.random)
    }
}
