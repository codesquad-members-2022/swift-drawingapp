//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class DrawingModelFactory {    
    static func makeModel() -> DrawingModel {
        let id = makeId()
        let size = SizeFactory.make()
        let point = PointFactory.make()
        let color = ColorFactory.make()
        let alpha = Alpha.allCases.randomElement() ?? .transpar10
        
        return DrawingModel(id: id, point: point, size: size, color: color, alpha: alpha)
    }
    
    static func makeModel(url: URL) -> PhotoModel {
        let id = makeId()
        let size = SizeFactory.make()
        let point = PointFactory.make()
        let alpha = Alpha.transpar10
        return PhotoModel(id: id, point: point, size: size, alpha: alpha, url: url)
    }
    
    private static func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
}
