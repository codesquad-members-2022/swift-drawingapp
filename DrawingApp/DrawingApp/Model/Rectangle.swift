//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Rectangle {
    
    private let id: String
    private let size: Size
    let point: Point
    private let backGroundColor: BackgroundColor
    private let alpha: Alpha
    
    init(id: String, size: Size, point: Point, backGroundColor: BackgroundColor, alpha: Alpha) {
        self.id = id
        self.size = size
        self.point = point
        self.backGroundColor = backGroundColor
        self.alpha = alpha
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(point), \(point), \(backGroundColor), \(alpha)"
    }
}

extension Rectangle: Equatable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.id == rhs.id
    }
}
