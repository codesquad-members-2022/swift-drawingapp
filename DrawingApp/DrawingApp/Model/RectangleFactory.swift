//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

struct RectangleFactory {

    static func makeRandomRectangle(in screenSize : (Double,Double)) -> Rectangle? {
        let randomPosition = RandomGenerator.generatePosition(screenSize: screenSize)
        let randomColor = RandomGenerator.generateColor()
        let randomAlpha = RandomGenerator.generateAlpha()
        
        guard let randomColor = randomColor else {return nil}
        guard let randomAlpha = randomAlpha else {return nil}
        
        return Rectangle(size: Size(width: 150, height: 120), position: randomPosition, color: randomColor, alpha: randomAlpha)
    }
    
    
}
