//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class Rectangle: Shape {
    let id: String

    private var size: Size
    
    private var point: Point
    
    private var color: Color
    
    private var alpha: Alpha
    
    init(id: String, point: Point, size: Size, color: Color, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
    
    func isContainPoint(_ point: Point) -> Bool {
        let rectangleX = self.point.getCurrentX()
        let rectangleY = self.point.getCurrentY()
        let isContainX = (rectangleX...rectangleX + self.size.getCurrentWidth()).contains(point.getCurrentX())
        let isContainY = (rectangleY...rectangleY + self.size.getCurrentHeight()).contains(point.getCurrentY())
        return isContainX && isContainY
    }
    
    func getSize() -> Size {
        return size
    }
    
    func getPoint() -> Point {
        return point
    }
    
    func getColor() -> Color {
        return color
    }
    
    func getAlpha() -> Alpha {
        return alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "Rectangle(\(self.id)) : \(self.point), \(self.size), \(self.color), \(self.alpha)"
    }
}
