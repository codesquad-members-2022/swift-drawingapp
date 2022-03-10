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
    var specifiedRectangle: Rectangle?
    var addedRectangle: Rectangle?
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    mutating public func specifyRectangle(point: Point) {
        for rectangle in rectangles.reversed() {
            if rectangle.isPointInArea(point) {
                self.specifiedRectangle = rectangle
                delegate?.planeDidSpecifyRectangle(self)
                return
            }
        }
        self.specifiedRectangle = nil
    }
    
    mutating public func addNewRectangle(in frame: (width: Double, height: Double)) {
        let newRectangle = RectangleFactory.makeRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        self.addedRectangle = newRectangle
        delegate?.planeDidAddRectangle(self)
    }
    
    public func changeBackgroundColor(to newColor: BackgroundColor) -> Rectangle? {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return nil
        }
        specifiedRectangle.changeBackgroundColor(to: newColor)
        delegate?.planeDidChangeBackgroundColorOfRectangle(self)
        return specifiedRectangle
    }

    public func changeAlphaValue(to newAlpha: Alpha) -> Rectangle? {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return nil
        }
        specifiedRectangle.changeAlphaValue(to: newAlpha)
        delegate?.planeDidChangeAlphaOfRectangle(self)
        return specifiedRectangle
    }

}
