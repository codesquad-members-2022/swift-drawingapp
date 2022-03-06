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
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    public func getRectangle(id: ID) -> Rectangle? {
        for rectangle in rectangles {
            if rectangle.id == id {
                return rectangle
            }
        }
        return nil
    }
    
    public func addNewRectangle(in frame: (Double, Double)) {
        let newRectangle = RectangleFactory.generateRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        generateRectangleViewDelegate?.planeDidAddRectangle(newRectangle)
    }
}
