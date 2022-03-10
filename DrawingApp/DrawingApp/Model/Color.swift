//
//  Color.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation

class Color {
    private let red: Int
    private let green: Int
    private let blue: Int
    
    init(red: Int, green: Int, blue: Int) {
        let minValue = 0
        let maxValue = 255
        
        self.red = red < minValue ? minValue : (red > maxValue ? maxValue : red)
        self.green = green < minValue ? minValue : (green > maxValue ? maxValue : green)
        self.blue = blue < minValue ? minValue : (blue > maxValue ? maxValue : blue)
    }
    
    func getHexValue() -> String {
        var hexRed = String(red, radix: 16)
        var hexGreen = String(green, radix: 16)
        var hexBlue = String(blue, radix: 16)
        
        if hexRed.count == 1 {
            hexRed = "0" + hexRed
        }
        
        if hexGreen.count == 1 {
            hexGreen = "0" + hexGreen
        }
        
        if hexBlue.count == 1 {
            hexBlue = "0" + hexBlue
        }
        
        return "0x" + hexRed + hexGreen + hexBlue
    }
}


extension Color: CustomStringConvertible {
    var description: String {
        return "R:\(red), G:\(green), B:\(blue), hexValue: \(getHexValue())"
    }
}
