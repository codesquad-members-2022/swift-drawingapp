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
    
    static func generateColor() -> Color {
        var randomInt: Int {
            (Color.Range.min...Color.Range.max).randomElement() ?? 0
        }
        @Clamping(min: Color.Range.min, max: Color.Range.max) var randomRed: Int = randomInt
        @Clamping(min: Color.Range.min, max: Color.Range.max) var randomGreen: Int = randomInt
        @Clamping(min: Color.Range.min, max: Color.Range.max) var randomBlue: Int = randomInt
        let randomColor = Color(red: randomRed, green: randomGreen, blue: randomBlue)
        return randomColor
    }
    
    static func generateAlpha() -> Alpha {
        var randomDouble: Double {
            Double.random(in: Alpha.Range.min...Alpha.Range.max)
        }
        
        @Clamping(min: Alpha.Range.min, max: Alpha.Range.max) var randomTransparency = randomDouble
        
        return Alpha(transparency: randomTransparency)
    }
    
}
