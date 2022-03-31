//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/30.
//

import Foundation

class Rectangle: showRect {
    private(set) var id: Identifier
    private(set) var point: Point
    private(set) var size: Size
    private(set) var backgroundColor: BackgroundColor
    private(set) var alpha: Alpha
    
    init(id: Identifier, point: Point, size: Size, backGroundColor: BackgroundColor, alpha: Alpha)
        {
            self.id = id
            self.point = point
            self.size = Size(width: 150, height: 120)
            self.backgroundColor = backGroundColor
            self.alpha = alpha
        }
}

protocol showRect: CustomStringConvertible {
    var id: Identifier { get }
    var point: Point { get }
    var size: Size { get }
    var backgroundColor: BackgroundColor { get }
    var alpha: Alpha { get }
}

extension showRect {
    var description: String {
        return "(\(self.id), \(self.point), \(self.size), \(self.backgroundColor), \(self.alpha))"
    }
}
