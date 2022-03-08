//
//  Plane.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/03.
//

import Foundation

struct Plane {
    private var rectangles = [Rectangle]()
    var delegate: PlaneDelegate?
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    public func specifyRectangle(point: Point) -> Rectangle? {
        for rectangle in rectangles.reversed() {
            if rectangle.isPointInArea(point) {
                delegate?.rectangleDidSpecified(rectangle)
                return rectangle
            }
        }
        return nil
    }
    
    mutating public func addNewRectangle(in frame: (width: Double, height: Double)) {
        let newRectangle = RectangleFactory.makeRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        delegate?.rectangleDidAdded(newRectangle)
    }
    
    public func changeBackGroundColor(of rectangle: Rectangle, to newColor: BackgroundColor) {
        rectangle.changeBackgroundColor(to: newColor)
        delegate?.rectangleBackgroundColorDidChanged(rectangle)
    }

    public func changeAlphaValue(of rectangle: Rectangle, to newAlpha: Alpha) {
        rectangle.changeAlphaValue(to: newAlpha)
        delegate?.rectangleAlphaDidChanged(rectangle)
    }
}
