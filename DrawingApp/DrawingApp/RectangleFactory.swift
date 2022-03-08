//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation
import os

class RectangleFactory {
    func createRectangle() {
        let rectangle = Rectangle(id: createRandomId(), point: createRandomPoint(), size: createRandomSize(), backgroundColor: createRandomColor(), alpha: try! createRandomAlpha())
        let log = Logger()
        log.info("Rect: \(rectangle)")
    }
    
    
    func createRandomId() -> Id {
        return Id()
    }
    
    
    func createRandomPoint() -> Point {
        return Point(x: 10, y: 200)
    }
    
    
    func createRandomSize() -> Size {
        return Size(width: 150, height: 120)
    }
    
    
    func createRandomColor() -> Color {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return Color(red: red, green: green, blue: blue)
    }
    
    
    func createRandomAlpha() throws -> Alpha {
        guard let alphaValue = Alpha.allCases.randomElement() else {
            throw RectangleError.invalidAlphaValue
        }
        return alphaValue
    }
}
