//
//  RandomGenerator.swift
//  DrawingApp
//
//  Created by dale on 2022/03/10.
//

import Foundation

struct RandomGenerator {
    
    static func generatePosition(screenSize: (Double,Double)) -> Position {
        let screenWidth = screenSize.0
        let screenHeight = screenSize.1
        let randomCoordinate = {range in
            Double.random(in: 0...range)
        }
        let randomX = randomCoordinate(screenWidth)
        let randomY = randomCoordinate(screenHeight)
        return Position(x: randomX, y: randomY)
    }
    
    static func generateColor() -> Color? {
        var randomInt: Int {
            Color.colorRange.randomElement() ?? 0
        }
        guard let randomColor = Color(red: randomInt, green: randomInt, blue: randomInt) else {return nil}
        return randomColor
    }
    
    static func generateAlpha() -> Alpha? {
        let randomTransparency = Double.random(in: Alpha.alphaRange)
        return Alpha(transparency: randomTransparency)
    }
    
}
