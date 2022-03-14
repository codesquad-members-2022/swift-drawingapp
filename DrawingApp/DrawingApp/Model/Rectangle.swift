//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation

class Rectangle: Shapable {
    
    private(set) var id: Identifier
    private(set) var size: Size
    private(set) var point: Point
    private(set) var backGroundColor: Color
    private(set) var alpha: Alpha
    
    init(identifier: Identifier,
         size: Size = Size(width: 150, height: 120),
         point: Point,
         backGroundColor: Color,
         alpha: Alpha)
    {
        self.id = identifier
        self.size = size
        self.point = point
        self.backGroundColor = backGroundColor
        self.alpha = alpha
    }
    
    func getTransparency() -> Float {
        return Float(alpha.value)
    }

    func canAlphaLevelUp() -> Bool {
        return !alpha.isMaxLevel
    }
    
    func canAlphaLevelDown() -> Bool {
        return !alpha.isMinLevel
    }
    
    func upAlphaLevel() {
        if canAlphaLevelUp(), let nextAlphaLevel = alpha.nextLevel {
            alpha = nextAlphaLevel
        }
    }
    
    func downAlphaLevel() {
        if canAlphaLevelDown(), let previousAlphaLevel = alpha.previousLevel {
            alpha = previousAlphaLevel
        }
    }
}

extension Rectangle: Hashable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
