//
//  Plane.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/04.
//

import Foundation

struct Plane {
    var delegate: PlaneDelegate?

    private var rectangles: [Rectangle] = []
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    var count: Int {
        return rectangles.count
    }
    
    private(set) var recentlySelectedRectangle: Rectangle?
    
    
    mutating func updateRecentlySelected(rectangle: Rectangle) {
        self.recentlySelectedRectangle = rectangle
    }
    
    mutating func append(newRectangle: Rectangle) {
        self.rectangles.append(newRectangle)
        delegate?.didCreateRectangle(newRectangle)
    }
    
    func isRectangleExist(on coordinate: (x: Double, y: Double), target rectangle: Rectangle) -> Bool {
        let xBound = (rectangle.point.x)...(rectangle.point.x + rectangle.size.width)
        let yBound = (rectangle.point.y)...(rectangle.point.y + rectangle.size.height)
        
        if (xBound ~= coordinate.x) && (yBound ~= coordinate.y) {
            return true
        }
        
        return false
    }
    
    func searchRectangle(on coordinate: (x: Double, y: Double)) {
        for rectangle in rectangles.reversed() {
            if isRectangleExist(on: coordinate, target: rectangle) {
                delegate?.didSelectRectanlge(rectangle)
                return
            }
        }
        
        delegate?.didSelectRectanlge(nil)
    }
}
