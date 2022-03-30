//
//  Plane.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/11.
//

import Foundation

struct Plane {
    private let factory = ShapeFactory()
    private var shapeArray = Array<Shape>()
    private var selectedShape: Shape? = nil
    
    var rectangleCount: Int {
        get {
            return shapeArray.count
        }
    }
    
    subscript(index: Int) -> Rectangle? {
        if index < rectangleCount, shapeArray[index] is Rectangle {
            return shapeArray[index] as? Rectangle
        }
        return nil
    }
    
    mutating func getRectangleAtPoint(x: Double, y: Double) -> Rectangle? {
        for index in 0..<shapeArray.count {
            let shape = shapeArray[shapeArray.count - index - 1]
            if  shape is Rectangle,
                shape.isContainPoint(Point(x: x, y: y)) {
                return shape as? Rectangle
            }
        }
        return nil
    }
    
    func isThereSelectedShape() -> Bool {
        return selectedShape != nil
    }
    
    func getSelectedShapePoint() -> Point? {
        return selectedShape?.getPoint()
    }
    
    func getSelectedShapeColor() -> Color? {
        return selectedShape?.getColor()
    }
    
    func getSelectedShapeAlpha() -> Alpha? {
        return selectedShape?.getAlpha()
    }
    
    mutating func setSelectedShape(to shape: Shape) {
        selectedShape = shape
    }
    
    mutating func resetSelectedShape() {
        selectedShape = nil
    }
    
    mutating func makeNewRandomRectangle() -> Rectangle {
        let rectangle = factory.createRandomRectangle()
        shapeArray.append(rectangle)
        return rectangle
    }
    
    mutating func resetSelectedRectangleRandomRGB() -> Rectangle? {
        guard let currentRectangle = selectedShape, selectedShape is Rectangle else {
            return nil
        }
        
        let newRectangle = factory.createRectangle(point: currentRectangle.getPoint(),
                                                   size: currentRectangle.getSize(),
                                                   color: Color.generateRandomColor(),
                                                   alpha: currentRectangle.getAlpha())
        setSelectedShape(to: newRectangle)
        return newRectangle
    }
    
    mutating func resetSelectedRectangleAlpha(to alpha: Alpha) {
        guard let currentRectangle = selectedShape, selectedShape is Rectangle else {
            return
        }
        
        let newRectangle = factory.createRectangle(point: currentRectangle.getPoint(),
                                                   size: currentRectangle.getSize(),
                                                   color: currentRectangle.getColor(),
                                                   alpha: alpha)
        setSelectedShape(to: newRectangle)
    }
    
    func generateRandomRGBA() -> (r: Double, g: Double, b: Double, a: Double) {
        var result: (r: Double, g: Double, b: Double, a: Double) = (0.0, 0.0, 0.0, 0.0)
        result.r = Double.random(in: 0...255) / 255
        result.g = Double.random(in: 0...255) / 255
        result.b = Double.random(in: 0...255) / 255
        result.a = Double.random(in: 1...10) / 10
        return result
    }
}
