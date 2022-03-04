//
//  Plane.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

struct Plane{
    private var rectangles: [String:Rectangle] = [:]
    subscript(id: String) -> Rectangle?{
        return rectangles[id]
    }
    mutating func addRectangle(rectangle: Rectangle){
        rectangles[rectangle.idValue()] = rectangle
    }
}
