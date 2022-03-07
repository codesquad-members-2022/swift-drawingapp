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
    
    var count: Int {
        return rectangles.count
    }
    
    mutating func append(newRectangle: Rectangle) {
        self.rectangles.append(newRectangle)
        delegate?.rectangleDidCreated(newRectangle)
    }
}
