//
//  Plane.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/11.
//

import Foundation

struct Plane {
    private var rectangleArray: Array<Shape> = Array<Rectangle>()
    
    var rectangleCount: Int {
        get {
            return rectangleArray.count
        }
    }
    
    subscript(index: Int) -> Rectangle? {
        if index < rectangleCount, rectangleArray[index] is Rectangle {
            return rectangleArray[index] as? Rectangle
        }
        return nil
    }
    
    mutating func addRectangle(_ rectangle: Shape) {
        if rectangle is Rectangle {
            rectangleArray.append(rectangle)
        }
    }
    
    func isThereARectangle(point: Point) -> Bool {
        for rectangle in rectangleArray {
            if rectangle.isContainPoint(point) {
                return true
            }
        }
        return false
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
