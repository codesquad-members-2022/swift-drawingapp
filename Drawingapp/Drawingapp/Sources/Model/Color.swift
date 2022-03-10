//
//  Color.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

struct Color: CustomStringConvertible {
    let r: UInt8
    let g: UInt8
    let b: UInt8
    
    var hexColor: String {
        "#\(hexaFromDecimal(r))\(hexaFromDecimal(g))\(hexaFromDecimal(b))"
    }
    
    var description: String {
        "R: \(r), G: \(g), B: \(b)"
    }
    
    init<T: ColorValueGenerator>(using generator: T) {
        let colorR = generator.colorR
        let colorG = generator.colorG
        let colorB = generator.colorB
        self.r = colorR
        self.g = colorG
        self.b = colorB
    }
    
    init(r: UInt8, g: UInt8, b: UInt8) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    private func hexaFromDecimal(_ value: UInt8) -> String {
        var hex = String(value, radix: 16)
        hex = hex.count == 1 ? "0" + hex : hex
        return hex
    }
}
