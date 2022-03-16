//
//  ViewObject.swift
//  DrawingApp
//
//  Created by dale on 2022/03/16.
//

import Foundation

class Shape{
    private(set) var id : Id = Id()
    private(set) var size : Size
    private(set) var position : Position
    private(set) var alpha : Alpha
    
    init(size: Size, position : Position, alpha : Alpha) {
        self.size = size
        self.position = position
        self.alpha = alpha
    }
    
    func setAlpha(to alpha: Alpha) {
        self.alpha = alpha
    }
}

extension Shape: Equatable, Hashable {
    static func == (lhs: Shape, rhs: Shape) -> Bool {
         return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
