//
//  RectFactory.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/30.
//

import Foundation

class RectFactory {
    func createRectangle(id: Identifier,
                         point: Point,
                         size: Size,
                         alpha: Alpha,
                         color: BackgroundColor) -> Rectangle {
        return Rectangle(id: id, point: point, size: size, backGroundColor: color, alpha: alpha)
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
    
    func createRandomRect() -> showRect {
        return Rectangle(id: generateRandomIdentifier(),
                         point: generateRandomPoint(),
                         size: generateRandomSize(),
                         backGroundColor: generateRandomColor(), alpha: generateRandomAlpha())
    }
    
}
