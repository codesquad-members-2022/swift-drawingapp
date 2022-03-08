//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation
import os

class RectangleFactory {
    func createRectangle() -> Rectangle {
        let rectangle = Rectangle(id: createRandomId(), point: createRandomPoint(), size: createRandomSize(), backgroundColor: createRandomColor(), alpha: try! createRandomAlpha())
        let log = Logger()
        log.info("Rect: \(rectangle)")
        return rectangle
    }
    
    
    func createRandomId() -> Id {
        return Id()
    }
    
    
    func createRandomPoint() -> Point {
        let x = Double.random(in: 0...200)
        let y = Double.random(in: 0...200)
        return Point(x: x, y: y)
    }
    
    
    func createRandomSize() -> Size {
        let width = Double.random(in: 100.0...200.0)
        let height = Double.random(in: 100.0...200.0)
        return Size(width: width, height: height)
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
