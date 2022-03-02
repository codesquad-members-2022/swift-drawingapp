//
//  TypeDataFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/02.
//

import Foundation
import UIKit

class TypeDataFactory {
    
    func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
    
    func makeSize() -> Size{
        Size(width: 150, height: 120)
    }
    
    func makePoint() -> Point {
        let screenSize = UIScreen.main.bounds.size
        let pointX = Int.random(in: 0..<Int(screenSize.width))
        let pointY = Int.random(in: 0..<Int(screenSize.height))
        return Point(x: pointX, y: pointY)
    }
    
    func makeColor() -> Color {
        let colorValues = (0..<3).map{ _ in Int.random(in: 0...255) }
        return Color(r: colorValues[0], g: colorValues[1], b: colorValues[2])
    }
    
    func makeAlpha() -> Alpha {
        return Alpha.allCases.randomElement() ?? .ten
    }
}
