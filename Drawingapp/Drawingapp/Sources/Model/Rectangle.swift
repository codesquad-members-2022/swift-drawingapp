//
//  Square.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Rectangle: CustomStringConvertible {
    let id: String
    let point: Point
    let size: Size
    var color: Color
    var alpha: Alpha
    
    var description: String {
        "id: ( \(id) ), \(point), \(size), \(color), alpha: \(alpha)"
    }
    
    init(id: String, point: Point, size: Size, color: Color, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
    
    func isSelected(by touchPoint: Point) -> Bool {
        if touchPoint.x >= point.x, touchPoint.y >= point.y,
           touchPoint.x <= point.x + size.width, touchPoint.y <= point.y + size.height {
            return true
        }
        return false
    }
    
    func update(color: Color) {
        self.color = color
    }
    
    func update(alpha: Alpha) {
        self.alpha = alpha
    }
}
