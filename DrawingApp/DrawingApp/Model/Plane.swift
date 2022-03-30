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
    var selectedShape: Shape? = nil
    
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
    
    mutating func selectRectangle(x: Double, y: Double) -> Rectangle? {
        for shape in shapeArray {
            if  shape is Rectangle,
                shape.isContainPoint(Point(x: x, y: y)) {
                print("사각형 있음")
                selectedShape = shape
                return shape as? Rectangle
            }
        }
        selectedShape = nil
        return nil
    }
    
    func isThereARectangle(point: Point) -> Bool {
        for rectangle in shapeArray {
            if rectangle.isContainPoint(point) {
                return true
            }
        }
        return false
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
