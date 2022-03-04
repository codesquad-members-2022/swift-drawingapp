//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation

class RectangleFactory {
    func createRectangle() {
        
    }
    
    
    func createPoint() -> Point {
        return Point(x: 10, y: 200)
    }
    
    
    func createSize() -> Size {
        return Size(width: 150, height: 120)
    }
    
    
    func createColor() -> Color {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return Color(red: red, green: green, blue: blue)
    }
    
    
    func createAlpha() throws -> Alpha {
        guard let alphaValue = Alpha.allCases.randomElement() else {
            throw RectangleError.invalidAlphaValue
        }
        return alphaValue
    }
}
