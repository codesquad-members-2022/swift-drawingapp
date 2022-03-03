//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class DrawingModelFactory {
    
    private let sizeFactory = SizeFactory()
    private let pointFactory = PointFactory()
    private let colorFactory = ColorFactory()
    
    func makeSquare() -> Square {
        let id = makeId()
        let size = sizeFactory.make()
        let point = pointFactory.make()
        let color = colorFactory.make()
        let alpha = Alpha.allCases.randomElement() ?? .ten
        
        return Square(id: id, point: point, size: size, color: color, alpha: alpha)
    }
    
    private func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
}
