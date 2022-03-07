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
}


extension Color: CustomStringConvertible {
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
}
