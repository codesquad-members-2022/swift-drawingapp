//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class Rectangle: Shape {
    let id: String

    var size: Size
    
    var point: Point
    
    var backgroundColor: BackgroundColor
    
    var alpha: Int
    
    required init(id: String, size: Size, point: Point, backgroundColor: BackgroundColor, alpha: Int) {
        self.id = id
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
}
