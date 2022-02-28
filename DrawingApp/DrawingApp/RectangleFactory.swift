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
    func make() -> Rectangle {
        return Rectangle(id: Id(), width: 150, height: 120, position: randomPosition(), color: randomColor(), alpha: randomAlpha())
    }
    
    private func randomPosition() -> Position {
        let screenWidth = screenSize.0
        let screenHeight = screenSize.1
        let randomCoordinate = {range in
            Double.random(in: 0...range)
        }
        let randomX = randomCoordinate(screenWidth)
        let randomY = randomCoordinate(screenHeight)
        return Position(x: randomX, y: randomY)
    }
    
    private func randomColor() -> (Int,Int,Int){
        var randomInt: Int {
            (0..<255).randomElement() ?? 0
        }
        return (randomInt,randomInt,randomInt)
    }
    
    private func randomAlpha() -> Int {
        return (1...10).randomElement() ?? 5
    }
    
}
