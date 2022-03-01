//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation

class ShapeFactory {
    private func generateRandomIdentifier(tokenLength: Int, delimiter: Character, totalLength: Int) -> String {
        let characters = Array(ShapeBound.Id.alphaNumeric)

        var id = ""
        (1...totalLength).forEach { count in
            let randomCharacter = characters[Int.random(in: (0..<characters.count))]
            id.append(randomCharacter)
            
            if (count % tokenLength == 0) && (count != totalLength) {
                id.append(delimiter)
            }
        }
        return id
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
        
        return Color(red: randomRed, green: randomGreen, blue: randomBlue, alpha: Alpha.randomAlpha)
    }
}

extension ShapeFactory: ShapeFactorable {
    
    func createShape(shapeType: ShapeType) -> Shapable {
        switch shapeType {
        case .Rectangle:
            return Rectangle(identifier: generateRandomIdentifier(tokenLength: 3, delimiter: "-", totalLength: 9),
                             size: generateRandomSize(),
                             point: generateRandomPoint(),
                             backGroundColor: generateRandomColor())
        }
    }
}

