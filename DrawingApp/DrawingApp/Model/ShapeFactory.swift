//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

struct ShapeFactory {

    static func makeRandomShape(in screenSize : (Double,Double)) -> Shape? {
        let randomPosition = RandomGenerator.generatePosition(screenSize: screenSize)
        let randomColor = RandomGenerator.generateColor()
        let randomAlpha = RandomGenerator.generateAlpha()
        
        return Rectangle(size: Size(width: 150, height: 120), position: randomPosition, color: randomColor, alpha: randomAlpha)
    }
    
    static func makePhotoShape(in screenSize : (Double, Double), imageData: Data) -> Shape? {
        let randomPosition = RandomGenerator.generatePosition(screenSize: screenSize)
        let randomAlpha = RandomGenerator.generateAlpha()

        return PhotoRectangle(size: Size(width: 150, height: 120), position: randomPosition, imageData: imageData, alpha: randomAlpha)
    }
    
    
}
