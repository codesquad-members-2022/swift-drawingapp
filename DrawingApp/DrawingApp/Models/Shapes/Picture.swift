//
//  Picture.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/29.
//

import Foundation

class Picture: BasicShape {
    
    private(set) var alpha: Alpha
    private(set) var imageBinaryData: Data
    
    init(identifier: Identifier, point: Point, size: Size = Size(width: 150, height: 120), alpha: Alpha, imageBinaryData: Data) {
        self.alpha = alpha
        self.imageBinaryData = imageBinaryData
        super.init(identifier: identifier, point: point, size: size)
    }
}

extension Picture: Alphable {

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
