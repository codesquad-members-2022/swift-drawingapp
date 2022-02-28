//
//  Square.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Square: CustomStringConvertible {
    let id: String
    let size: Size
    let point: Point
    let backgroundColor: Color
    let alpha: Alpha
    
    init(id: String, size: Size = Size(width: 150, height: 120), point: Point = Point(x: 0, y: 0), backgroundColor: Color = .black, alpha: Alpha = Alpha.ten) {
        self.id = id
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    var description: String {
        "id: ( \(id) ), size: \(size), point: \(point), backgroundColor: \(backgroundColor), alpha: \(alpha)"
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
