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
    
    mutating func resetSelectedRectangleAlpha(to alpha: Alpha) -> Rectangle? {
        guard let currentRectangle = selectedShape, selectedShape is Rectangle else {
            return nil
        }
        
        let newRectangle = factory.createRectangle(point: currentRectangle.getPoint(),
                                                   size: currentRectangle.getSize(),
                                                   color: currentRectangle.getColor(),
                                                   alpha: alpha)
        setSelectedShape(to: newRectangle)
        return newRectangle
    }
}
