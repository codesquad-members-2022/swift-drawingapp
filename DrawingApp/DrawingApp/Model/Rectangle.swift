//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation

final class Rectangle: BasicShape {
    
    private(set) var backgroundColor: Color
    private(set) var alpha: Alpha
    
    init(identifier: Identifier,
         point: Point,
         size: Size = Size(width: 150, height: 120),
         backgroundColor: Color,
         alpha: Alpha)
    {
        self.backgroundColor = backgroundColor
        self.alpha = alpha
        super.init(identifier: identifier, point: point, size: size)
    }
}

extension Rectangle: Colorable {
    func changeBackgroundColor(by backgroundColor: Color) {
        self.backgroundColor = backgroundColor
    }
}

extension Rectangle: Alphable {

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
