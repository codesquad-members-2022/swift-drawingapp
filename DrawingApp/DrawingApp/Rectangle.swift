//
//  RectangleGenerator.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Rectangle {
    private let id : Id
    private var size : Size
    private var position : Position
    private var backGroundColor : Color
    private var alpha : Int
    
    init(id: Id, size: Size, position : Position, color : Color, alpha : Int) {
        self.id = id
        self.size = size
        self.position = position
        self.backGroundColor = color
        self.alpha = alpha
    }
    
}

extension Rectangle : CustomStringConvertible {
    var description: String {
        var positionXY = self.position.description.components(separatedBy: ",")
        return "(\(self.id)), \(position), \(self.size), \(self.backGroundColor) , Alpha:\(self.alpha)"
    }
}
