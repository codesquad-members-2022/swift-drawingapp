//
//  Plane.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation

struct Plane {
    private var rectangles = [Rectangle]()
    var numberOfRect : Int {
        self.rectangles.count
    }
    subscript(index: Int) -> Rectangle?{
        get {
            guard numberOfRect > index else {
                return nil
            }
            return rectangles[index]
        }
    }
    
    mutating func append(_ rect : Rectangle) {
        self.rectangles.append(rect)
    }
    
   
}
