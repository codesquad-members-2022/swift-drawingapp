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
    var changeRectangleBackgroundColorDelegate: ChangeRectangleBackgroundColorDelegate?
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    public func specifyRectangle(id: ID) -> Rectangle? {
        for rectangle in rectangles {
            if rectangle.id == id {
                return rectangle
            }
        }
        return nil
    }
    
    public func addNewRectangle(in frame: (Double, Double)) {
        guard let newRectangle = RectangleFactory.generateRandomRectangle(in: frame) else { return }
        rectangles.append(newRectangle)
        generateRectangleViewDelegate?.planeDidAddRectangle(newRectangle)
    }
    
    public func changeBackGroundColorOfRectangle(id: ID) {
        for rectangle in rectangles {
            if rectangle.id == id {
                rectangle.changeBackgroundColorRandomly()
                changeRectangleBackgroundColorDelegate?
                    .rectangleDidChangeBackgroundColor(to: rectangle.backgroundColor, alpha: rectangle.alpha)
            }
        }
    }
}
