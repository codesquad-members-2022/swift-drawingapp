//
//  Plane.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/11.
//

import Foundation

struct Plane {
    private var rectangleArray = Array<Rectangle>()
    
    var rectangleCount: Int {
        get {
            return rectangleArray.count
        }
    }
    
    subscript(index: Int) -> Rectangle? {
        if index < rectangleCount {
            return rectangleArray[index]
        }
        return nil
    }
}
