//
//  Square.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation

protocol viewModel {
    func contains(_ point: Point) -> Bool
}

class Rectangle: viewModel, CustomStringConvertible {
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
    
    func contains(_ point: Point) -> Bool {
        return (origin.x...origin.x+size.width).contains(point.x)
        && (origin.y...origin.y+size.height).contains(point.y)
    }
    
    var description: String {
        return "(\(id)), \(origin), \(size), \(color), \(alpha)"
    }
}

