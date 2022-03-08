//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

protocol RectangleFactoryDelegate {
    func didMadeRectangle(rectangle: Rectangle)
}

class RectangleFactory {
    private let screenSize : (Double,Double)
    var delegate : RectangleFactoryDelegate?
    
    init(screenSize : (Double,Double)) {
        self.screenSize = screenSize
    }
    func makeRandomRectangle() {
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
        
        var randomColor : Color? {
            var randomInt: Int {
                Color.colorRange.randomElement() ?? 0
            }
            guard let randomColor = Color(red: randomInt, green: randomInt, blue: randomInt) else {return nil}
            return randomColor
        }

        
        var randomAlpha : Alpha? {
            let randomTransparency = Double.random(in: Alpha.alphaRange)
            return Alpha(transparency: randomTransparency)
        }
        guard let randomColor = randomColor else {return}
        guard let randomAlpha = randomAlpha else {return}
        delegate?.didMadeRectangle(rectangle: Rectangle(size: Size(width: 150, height: 120), position: randomPosition, color: randomColor, alpha: randomAlpha))
    }
    
    
}
