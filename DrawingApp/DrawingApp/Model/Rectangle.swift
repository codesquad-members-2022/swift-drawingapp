//
//  RectangleGenerator.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Rectangle {
    let id : Id = Id()
    var size : Size
    var position : Position
    var backgroundColor : Color?
    var alpha : Alpha
    
    init(size: Size, position : Position, color : Color?, alpha : Alpha) {
        self.size = size
        self.position = position
        self.backgroundColor = color
        self.alpha = alpha
    }
    
}

extension Rectangle : CustomStringConvertible, Equatable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
         return lhs.id === rhs.id &&
                lhs.size === rhs.size &&
                lhs.position === rhs.position &&
                lhs.backgroundColor === rhs.backgroundColor &&
                lhs.alpha === rhs.alpha
    }
    
    var description: String {
        return "(\(self.id)), \(position), \(self.size), \(String(describing: self.backgroundColor)) , \(self.alpha)"
    }
}
