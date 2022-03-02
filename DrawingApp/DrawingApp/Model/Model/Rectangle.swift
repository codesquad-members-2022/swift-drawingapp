//
//  Square.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation

class Rectangle: CustomStringConvertible {
    private var id: String
    private var origin: Point
    private var size: Size
    private var color: Color
    private var alpha: Alpha
    
    init(id: String, origin: Point, size: Size, color: Color, alpha: Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.color = color
        self.alpha = alpha
    }
    
    var description: String {
        return "(\(id)), \(origin), \(size), \(color), \(alpha)"
    }
}

