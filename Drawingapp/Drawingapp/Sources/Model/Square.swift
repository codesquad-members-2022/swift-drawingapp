//
//  Square.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Square: CustomStringConvertible {
    let id: String
    let point: Point
    let size: Size
    let backgroundColor: Color
    let alpha: Alpha
    
    var description: String {
        "id: ( \(id) ), \(point), \(size), \(backgroundColor), alpha: \(alpha)"
    }
    
    init(id: String, point: Point = Point(x: 0, y: 0), size: Size = Size(width: 150, height: 120), backgroundColor: Color = .black, alpha: Alpha = Alpha.ten) {
        self.id = id
        self.point = point
        self.size = size
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    func isSelected(by touchPoint: Point) -> Bool {
        if touchPoint.x >= point.x,
           touchPoint.y >= point.y,
           touchPoint.x <= size.width,
           touchPoint.y <= size.height {
            return true
        }
        return false
    }
}

extension Square {
    static func make() -> Square {
        Square(id: makeId())
    }
    
    private static func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
}
