//
//  Plane.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/08.
//

import Foundation

struct Plane {
    private var rectangles = [Rectangle]()
    private var rectangleCount: Int {
        return rectangles.count
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    mutating func rectangleDidCreated(rectangle: Rectangle) {
        rectangles.append(rectangle)
    }
}
