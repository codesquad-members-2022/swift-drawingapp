//
//  RectangleGenerator.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Rectangle {
    let id : Id
    var size : Size
    var position : Position
    var backGroundColor : Color
    var alpha : Alpha
    
    init(id: Id, size: Size, position : Position, color : Color, alpha : Alpha) {
        self.id = id
        self.size = size
        self.position = position
        self.backGroundColor = color
        self.alpha = alpha
    }
    
}

extension Rectangle : CustomStringConvertible, Equatable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
         return lhs.id === rhs.id &&
                lhs.size === rhs.size &&
                lhs.position === rhs.position &&
                lhs.backGroundColor === rhs.backGroundColor &&
                lhs.alpha === rhs.alpha
    }
    
    var description: String {
        return "(\(self.id)), \(position), \(self.size), \(self.backGroundColor) , \(self.alpha)"
    }
}
