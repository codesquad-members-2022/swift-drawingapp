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
    private var specifiedRectangle: Rectangle?
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
                delegate?.rectangleDidSpecified(rectangle)
                return
            }
        }
        self.specifiedRectangle = nil
    }
    
    mutating public func addNewRectangle(in frame: (width: Double, height: Double)) {
        let newRectangle = RectangleFactory.makeRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        delegate?.rectangleDidAdded(newRectangle)
    }
    
    public func changeBackGroundColor() -> Rectangle? {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return nil
        }
        let newColor = BackgroundColorFactory.makeRandomBackgroundColor()
        specifiedRectangle.changeBackgroundColor(to: newColor)
        delegate?.rectangleBackgroundColorDidChanged(specifiedRectangle)
        return specifiedRectangle
    }

    public func changeAlphaValue(to newAlpha: Alpha) -> Rectangle? {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return nil
        }
        specifiedRectangle.changeAlphaValue(to: newAlpha)
        delegate?.rectangleAlphaDidChanged(specifiedRectangle)
        return specifiedRectangle
    }
    
    public func stepUpAlphaValue() -> Rectangle? {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return nil
        }
        let newAlpha = specifiedRectangle.alpha.value + 0.1
        let normalizedNewAlpha = round(newAlpha * 10) / 10
        guard let newOpacityLevel = Alpha.OpacityLevel(rawValue: normalizedNewAlpha) else {
            return nil
        }
        specifiedRectangle.changeAlphaValue(to: Alpha(opacityLevel: newOpacityLevel))
        delegate?.rectangleAlphaDidChanged(specifiedRectangle)
        return specifiedRectangle
    }
    
    public func stepDownAlphaValue() -> Rectangle? {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return nil
        }
        let newAlpha = specifiedRectangle.alpha.value - 0.1
        let normalizedNewAlpha = round(newAlpha * 10) / 10
        guard let newOpacityLevel = Alpha.OpacityLevel(rawValue: normalizedNewAlpha) else {
            return nil
        }
        specifiedRectangle.changeAlphaValue(to: Alpha(opacityLevel: newOpacityLevel))
        delegate?.rectangleAlphaDidChanged(specifiedRectangle)
        return specifiedRectangle
    }
}
