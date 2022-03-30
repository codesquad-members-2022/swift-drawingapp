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
    
    func convertRGBToHexColorCode(_ r: Int, _ g: Int, _ b: Int) -> String {
        var hexR = String(r, radix: 16).uppercased()
        var hexG = String(g, radix: 16).uppercased()
        var hexB = String(b, radix: 16).uppercased()
        if r < 16 {
            hexR = "0" + hexR
        }
        if g < 16 {
            hexG = "0" + hexG
        }
        if b < 16 {
            hexB = "0" + hexB
        }
        return "#" + hexR + hexG + hexB
    }
}
