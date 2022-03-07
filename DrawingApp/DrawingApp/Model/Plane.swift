//
//  Plane.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/03.
//

import Foundation

class Plane {
    private var rectangles = [Rectangle]()
    var generateRectangleViewDelegate: GenerateRectangleViewDelegate?
    var updateViewMatchedRectangleDelegate: UpdateViewMatchedRectangleDelegate?
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    public func specifyRectangle(point: Point) {
        for rectangle in rectangles.reversed() {
            if rectangle.isPointInArea(point) {
                updateViewMatchedRectangleDelegate?.rectangleDidSpecified(rectangle)
                break
            }
        }
    }
    
    public func addNewRectangle(in frame: (Double, Double)) {
        guard let newRectangle = RectangleFactory.generateRandomRectangle(in: frame) else { return }
        rectangles.append(newRectangle)
        generateRectangleViewDelegate?.planeDidAddRectangle(newRectangle)
    }
    
    public func changeBackGroundColorOfRectangle(id: ID, to newColor: BackgroundColor) {
        for rectangle in rectangles {
            if rectangle.id == id {
                rectangle.changeBackgroundColor(to: newColor)
                break
            }
        }
    }
    
    public func changeAlphaValueOfRectangle(id: ID, to newAlphaValue: Double) {
        for rectangle in rectangles {
            if rectangle.id == id {
                rectangle.changeAlphaValue(to: newAlphaValue)
                break
            }
        }
    }
}
