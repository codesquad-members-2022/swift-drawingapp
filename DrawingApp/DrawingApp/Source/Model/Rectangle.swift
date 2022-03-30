//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/30.
//

import Foundation

class Rectangle {
    private(set) var id: Identifier
    private(set) var point: Point
    private(set) var size: Size
    private(set) var alpha: Alpha
    private(set) var backgroundColor: BackgroundColor
    
    init(id: Identifier, size: Size, point: Point, backGroundColor: BackgroundColor, alpha: Alpha)
        {
            self.id = id
            self.size = Size(width: 150, height: 120)
            self.point = point
            self.backgroundColor = backGroundColor
            self.alpha = alpha
        }
}
