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
    var backgroundImage: Data?
    var alpha : Alpha
    
    init(size: Size, position : Position, color : Color?, alpha : Alpha) {
        self.size = size
        self.position = position
        self.backgroundColor = color
        self.alpha = alpha
    }
    
    init(size: Size, position: Position, imageData: Data, alpha: Alpha) {
        self.size = size
        self.position = position
        self.backgroundImage = imageData
        self.alpha = alpha
    }
    
}

extension Rectangle : CustomStringConvertible, Equatable, Hashable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
         return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    var description: String {
        return "(\(self.id)), \(position), \(self.size), \(String(describing: self.backgroundColor)) , \(self.alpha)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
