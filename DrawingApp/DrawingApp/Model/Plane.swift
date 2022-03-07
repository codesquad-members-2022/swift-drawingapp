//
//  Plane.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/03.
//

import Foundation

struct Plane {
    private var rectangles = [Rectangle]()
    var generateRectangleViewDelegate: GenerateRectangleViewDelegate?
    var updateViewMatchedRectangleDelegate: UpdateViewMatchedRectangleDelegate?
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    public func specifyRectangle(point: Point) -> Rectangle? {
        for rectangle in rectangles.reversed() {
            if rectangle.isPointInArea(point) {
                updateViewMatchedRectangleDelegate?.rectangleDidSpecified(rectangle)
                return rectangle
            }
        }
        return nil
    }
    
    mutating public func addNewRectangle(in frame: (width: Double, height: Double)) {
        guard let newRectangle = RectangleFactory.generateRandomRectangle(in: frame) else { return }
        rectangles.append(newRectangle)
        generateRectangleViewDelegate?.planeDidAddRectangle(newRectangle)
    }
    
    public func changeBackGroundColorOfRectangle(id: ID, to newColor: BackgroundColor) -> Rectangle? {
        for rectangle in rectangles {
            if rectangle.id == id {
                rectangle.changeBackgroundColor(to: newColor)
                updateViewMatchedRectangleDelegate?.rectangleBackgroundColorDidChanged(rectangle)
                return rectangle
            }
        }
        return nil
    }
    
    public func changeAlphaValueOfRectangle(id: ID, to newAlpha: Alpha) -> Rectangle? {
        for rectangle in rectangles {
            if rectangle.id == id {
                rectangle.changeAlphaValue(to: newAlpha)
                updateViewMatchedRectangleDelegate?.rectangleAlphaDidChanged(rectangle)
                return rectangle
            }
        }
        return nil
    }
    
    mutating public func addSpecificRectangle(_ rectangle: Rectangle) { // 테스트용 메서드
        self.rectangles.append(rectangle)
    }
}
