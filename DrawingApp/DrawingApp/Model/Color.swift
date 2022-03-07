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

        if red < minValue {
            self.red = minValue
        } else if red > maxValue {
            self.red = maxValue
        } else {
            self.red = red
        }
        
        if green < minValue {
            self.green = minValue
        } else if green > maxValue {
            self.green = maxValue
        } else {
            self.green = green
        }
        
        if blue < minValue {
            self.blue = minValue
        } else if blue > maxValue {
            self.blue = maxValue
        } else {
            self.blue = blue
        }
    }
}


extension Color: CustomStringConvertible {
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
}
