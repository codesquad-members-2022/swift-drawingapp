//
//  RectFactory.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/30.
//

import Foundation

class RectFactory {
    func createRectangle(id: Identifier,
                         size: Size,
                         point: Point,
                         color: BackgroundColor,
                         alpha: Alpha) -> Rectangle {
        return Rectangle(id: id, size: size, point: point, backGroundColor: color, alpha: alpha)
    }
}

extension RectFactory: CreateRandomRect {
    func generateRandomIdentifier() -> Identifier {
        return Identifier()
    }
    
    func generateRandomSize() -> Size {
        return Size.randomSize()
    }
    
    func generateRandomPoint() -> Point {
        return Point.randomPoint()
    }
    
    func generateRandomColor() -> BackgroundColor {
        return BackgroundColor.randomColor()
    }
    
    func generateRandomAlpha() -> Alpha {
        return Alpha.random
    }
    
    func createRandomRect() -> Rectangle {
        return Rectangle(id: generateRandomIdentifier(),
                         size: generateRandomSize(),
                         point: generateRandomPoint(),
                         backGroundColor: generateRandomColor(),
                         alpha: generateRandomAlpha())
    }
    
}
