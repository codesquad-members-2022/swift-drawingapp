//
//  Plane.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/08.
//

import Foundation

struct Plane {
    var rectangles = [Rectangle]()
    
    var rectangleCount: Int {
        return rectangles.count
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
}
