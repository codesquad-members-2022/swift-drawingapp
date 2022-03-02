//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation

class ShapeFactory {
    private func generateRandomIdentifier(delimiter: Character) -> Identifier {
        let firstToken = Identifier.generateToken()
        let secondToken = Identifier.generateToken()
        let thirdToken = Identifier.generateToken()
        
        return Identifier(firstToken: firstToken, secondToken: secondToken, thirdToken: thirdToken, delimiter: delimiter)
    }

    private func generateRandomSize() -> Size {
        let range = (ShapeBound.Size.lowwer...ShapeBound.Size.upper)

        let randomWidth = round(Double.random(in: range))
        let randomHeight = round(Double.random(in: range))
        
        return Size(width: randomWidth, height: randomHeight)
    }
    
    private func generateRandomPoint() -> Point {
        let range = (ShapeBound.Point.lowwer...ShapeBound.Point.upper)
        
        let randomX = round(Double.random(in: range))
        let randomY = round(Double.random(in: range))
        
        return Point(x: randomX, y: randomY)
    }
    
    private func generateRandomColor() -> Color {
        let range = (ShapeBound.Color.lowwer...ShapeBound.Color.upper)
        
        let randomRed = round(Double.random(in: range))
        let randomGreen = round(Double.random(in: range))
        let randomBlue = round(Double.random(in: range))
        
        return Color(red: randomRed, green: randomGreen, blue: randomBlue, alpha: Alpha.random)
    }
}

extension ShapeFactory: ShapeFactorable {
    
    func createShape(shapeType: ShapeType) -> Shapable {
        switch shapeType {
        case .Rectangle:
            return Rectangle(identifier: generateRandomIdentifier(delimiter: "-"),
                             size: generateRandomSize(),
                             point: generateRandomPoint(),
                             backGroundColor: generateRandomColor(),
                             alpha: Alpha.random)
        }
    }
}

