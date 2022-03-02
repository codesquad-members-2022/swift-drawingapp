//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

class Factory {
    
    func makeDrawingItem(type: DrawingType) -> Square {
        switch type {
        case .square:
            return makeSquare()
        }
    }
    
    private func makeSquare() -> Square {
        let size = Size(width: 150, height: 120)
        
        let screenSize = UIScreen.main.bounds.size
        let pointX = Int.random(in: 0..<Int(screenSize.width - size.width))
        let pointY = Int.random(in: 0..<Int(screenSize.height - size.height))
        
        let colorValues = (0..<3).map{ _ in Int.random(in: 0...255) }
        let color = Color(r: colorValues[0], g: colorValues[1], b: colorValues[2])
        
        let alpha = Alpha.allCases.randomElement() ?? .ten
        
        return Square(id: makeId(), point: Point(x: pointX, y: pointY), size: size, color: color, alpha: alpha)
    }
    
    private func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
}

extension Factory {
    enum DrawingType {
        case square
    }
}
