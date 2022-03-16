//
//  RectangleGenerator.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Rectangle: Shape {
    var backgroundColor : Color
    
    init(size: Size, position : Position, color : Color, alpha : Alpha) {
        self.backgroundColor = color
        super.init(size: size, position: position, alpha: alpha)
    }
    
    func setBackgroundColor(to color: Color) {
        self.backgroundColor = color
    }
}

extension Rectangle : CustomStringConvertible{
    var description: String {
        return "(\(self.id)), \(position), \(self.size), \(String(describing: self.backgroundColor)) , \(self.alpha)"
    }
}
