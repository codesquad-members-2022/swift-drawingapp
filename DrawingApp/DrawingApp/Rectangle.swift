//
//  RectangleGenerator.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Rectangle {
    private var id : Id
    private var width : Double
    private var height : Double
    private var position : Position
    private var backGroundColor : Color
    private var alpha : Int
    
    init(id: Id, width : Double, height: Double, position : Position, color : Color, alpha : Int) {
        self.id = id
        self.width = width
        self.height = height
        self.position = position
        self.backGroundColor = color
        self.alpha = alpha
    }
    
}

extension Rectangle : CustomStringConvertible {
    var description: String {
        var positionXY = self.position.description.components(separatedBy: ",")
        return "(\(self.id)), \(position), W\(width), H\(height), \(self.backGroundColor) , Alpha:\(self.alpha)"
    }
}
