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
        "#\(hexaFromDecimal(r))\(hexaFromDecimal(g))\(hexaFromDecimal(b))"
    }
    
    var description: String {
        "R: \(r), G: \(g), B: \(b)"
    }
    
    init(r: UInt, g: UInt, b: UInt) {
        if r > 255, g > 255, b > 255 {
            self.r = 0
            self.g = 0
            self.b = 0
            return
        }
        self.r = r
        self.g = g
        self.b = b
    }
    
    private func hexaFromDecimal(_ value: UInt) -> String {
        var hex = String(value, radix: 16)
        hex = hex.count == 1 ? "0" + hex : hex
        return hex
    }
}

extension Color {
    static var black = Color(r: 0, g: 0, b: 0)
}
