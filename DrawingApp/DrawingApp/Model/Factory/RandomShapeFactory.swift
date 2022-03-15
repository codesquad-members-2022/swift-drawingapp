//
//  RandomShapeFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation

class RandomShapeFactory {
    
    static func createRandomBasicShape(xBound: Double, yBound: Double) -> BasicShape {
        return BasicShape(identifier: RandomAttributeFactory.generateRandomIdentifier(),
                          point: RandomAttributeFactory.generateRandomPoint(xBound: xBound, yBound: yBound),
                          size: Size(width: Size.Range.width, height: Size.Range.height))
    }
    
    static func createRandomRectangle(xBound: Double, yBound: Double) -> Rectangle {
        return Rectangle(identifier: RandomAttributeFactory.generateRandomIdentifier(),
                         point: RandomAttributeFactory.generateRandomPoint(xBound: xBound, yBound: yBound),
                         size: Size(width: Size.Range.width, height: Size.Range.height),
                         backgroundColor: RandomAttributeFactory.generateRandomColor(),
                         alpha: Alpha.random)
    }
}
