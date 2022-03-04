//
//  Color.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

struct Color: CustomStringConvertible {
    let r: UInt
    let g: UInt
    let b: UInt
    
    var hexColor: String {
        "#\(String(r, radix: 16))\(String(g, radix: 16))\(String(b, radix: 16))"
    }
    
    var description: String {
        "R: \(r), G: \(g), B: \(b)"
    }
    
    init(r: UInt, g: UInt, b: UInt) {
        self.r = r < 0 ? 0 : r > 255 ? 255 : r
        self.g = g < 0 ? 0 : g > 255 ? 255 : g
        self.b = b < 0 ? 0 : b > 255 ? 255 : b
    }
}

extension Color {
    static var black = Color(r: 0, g: 0, b: 0)
}
