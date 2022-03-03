//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class DrawingModelFactory {
    
    private let typeDataFactory = TypeDataFactory()
    
    func makeSquare() -> Square {
        let id = typeDataFactory.makeId()
        let size = typeDataFactory.makeSize()
        let point = typeDataFactory.makePoint()
        let color = typeDataFactory.makeColor()
        let alpha = typeDataFactory.makeAlpha()
        
        return Square(id: id, point: point, size: size, color: color, alpha: alpha)
    }
}
