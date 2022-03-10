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
    
    mutating public func specifyRectangle(point: Point) -> Result<Rectangle, PlaneError> {
        for rectangle in rectangles.reversed() {
            if rectangle.isPointInArea(point) {
                self.specifiedRectangle = rectangle
                delegate?.planeDidSpecifyRectangle(self)
                return .success(rectangle)
            }
        }
        self.specifiedRectangle = nil
        delegate?.planeDidSpecifyRectangle(self)
        return .failure(.cannotSpecifyRectangleError)
    }
    
    mutating public func addNewRectangle(in frame: (width: Double, height: Double)) {
        let newRectangle = RectangleFactory.makeRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        self.addedRectangle = newRectangle
        delegate?.planeDidAddRectangle(self)
    }
    
    public func changeBackgroundColor(to newColor: BackgroundColor) -> Result<Rectangle, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeBackgroundColor(to: newColor)
        delegate?.planeDidChangeBackgroundColorOfRectangle(self)
        return .success(specifiedRectangle)
    }

    public func changeAlphaValue(to newAlpha: Alpha) -> Result<Rectangle, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeAlphaValue(to: newAlpha)
        delegate?.planeDidChangeAlphaOfRectangle(self)
        return .success(specifiedRectangle)
    }

}

enum PlaneError: Error {
    case cannotSpecifyRectangleError
    case noSpecifiedRectangleToChangeError
}
