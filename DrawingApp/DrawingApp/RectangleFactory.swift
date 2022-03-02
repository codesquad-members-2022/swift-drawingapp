//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class RectangleFactory {
    private let screenSize : (Double,Double)
    init(screenSize : (Double,Double)) {
        self.screenSize = screenSize
    }
    func makeRandomRectangle() -> Rectangle? {
        var randomPosition : Position {
            let screenWidth = screenSize.0
            let screenHeight = screenSize.1
            let randomCoordinate = {range in
                Double.random(in: 0...range)
            }
            let randomX = randomCoordinate(screenWidth)
            let randomY = randomCoordinate(screenHeight)
            return Position(x: randomX, y: randomY)
        }
        
        var randomColor : Color?{
            var randomInt: Int {
                (255..<300).randomElement() ?? 0
            }
            guard let randomColor = Color(red: randomInt, green: randomInt, blue: randomInt) else {return nil}
            return randomColor
        }
        
        var randomAlpha : Alpha {
            guard let randomAlpha = Alpha.allCases.randomElement() else {
                return Alpha.ten
            }
            return randomAlpha
        }
        guard let randomColor = randomColor else {return nil}
        return Rectangle(id: Id(), size: Size(width: 150, height: 120), position: randomPosition, color: randomColor, alpha: randomAlpha)
    }
    
    
}
