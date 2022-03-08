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
    
    init<T: ColorValueGenerator>(using generator: T) {
        let colorR = generator.colorR
        let colorG = generator.colorG
        let colorB = generator.colorB
        
        assert(colorR > 0 && colorR < 255 )
        assert(colorG > 0 && colorG < 255 )
        assert(colorB > 0 && colorB < 255 )
        
        self.r = colorR
        self.g = colorG
        self.b = colorB
    }
    
    private init(r: UInt, g: UInt, b: UInt) {
        assert(r > 0 && r < 255 )
        assert(g > 0 && g < 255 )
        assert(b > 0 && b < 255 )
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
