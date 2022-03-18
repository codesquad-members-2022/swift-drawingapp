//
//  Plane.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/08.
//

import Foundation
import UIKit

struct Plane {
    var delegate: PlaneDelegate?
    
    private(set) var rectangles = [Rectangle]()
    var rectangleCount: Int {
        return rectangles.count
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    mutating func createRectangle() {
        let factory = RectangleFactory()
        let rectangle = factory.createRectangle()
        rectangles.append(rectangle)
        
        delegate?.planeDidAddRectangle(rectangle)
    }
    
    func findRectangle(on point: (x: Double, y: Double)) -> Rectangle? {
        for rectangle in rectangles.reversed() {
            if isRectangleExist(on: (x: point.x, y: point.y), rectangle: rectangle) {
                delegate?.planeDidTouchedRectangle(rectangle)
                return rectangle
            }
        }
        return nil
    }
    
    private func isRectangleExist(on point: (x: Double, y: Double), rectangle: Rectangle) -> Bool {
        let rangeOfX = (rectangle.point.x)...(rectangle.point.x + rectangle.size.width)
        let rangeOfY = (rectangle.point.y)...(rectangle.point.y + rectangle.size.height)
        return (rangeOfX ~= point.x && rangeOfY ~= point.y)
    }
    
    func backgroundColorDidChanged(color: Color, rectangle: Rectangle) {
        if let firstIndex = rectangles.firstIndex(of: rectangle) {
            rectangles[firstIndex].backgroundColor = color // 색상 변경
            delegate?.planeDidChangedRectangle(rectangles[firstIndex])
        }
    }
    
    func alphaValueDidChanged(alpha: Float, rectangle: Rectangle) {
        for rect in rectangles.reversed() {
            if rect == rectangle {
                // 투명도 변경
                rect.alpha = Alpha(rawValue: Int(alpha * 10))!
                delegate?.planeDidChangedRectangle(rect)
            }
        }
    }
}
