//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

class SquareFactory {
    
    private let typeDataFactory = TypeDataFactory()
    
    func makeDrawingItem(type: DrawingType) -> Square {
        switch type {
        case .square:
            return makeSquare()
        }
    }
    
    private func makeSquare() -> Square {
        let id = typeDataFactory.makeId()
        let size = typeDataFactory.makeSize()
        let point = typeDataFactory.makePoint()
        let color = typeDataFactory.makeColor()
        let alpha = typeDataFactory.makeAlpha()
        
        return Square(id: id, point: point, size: size, color: color, alpha: alpha)
    }
}

extension SquareFactory {
    enum DrawingType {
        case square
    }
}
