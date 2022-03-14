//
//  Square.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation

class Rectangle: Layer {
    
    private(set) var color: Color
    private(set) var alpha: Alpha
    
    init(title: String, id: ID, origin: Point, size: Size, color: Color, alpha: Alpha) {
        self.color = color
        self.alpha = alpha
        super.init(title: title, id: id, origin: origin, size: size)
    }
}

extension Rectangle: ColorMutable {
    func set(to color: Color) {
        self.color = color
    }
}

extension Rectangle: AlphaMutable {
    func set(to alpha: Alpha) {
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(origin), \(size), \(color), \(alpha)"
    }
}
