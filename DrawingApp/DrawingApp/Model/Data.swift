//
//  Point.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

struct Size: CustomStringConvertible {
    var description: String {
        return "W: \(self.width), H: \(self.height)"
    }
    
    var width: Double
    var height: Double
    
    init(width: Int, height: Int) {
        self.width = Double(width)
        self.height = Double(height)
    }
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

struct Point: CustomStringConvertible {
    var description: String {
        return "X: \(self.x), Y: \(self.y)"
    }
    
    var x: Double
    var y: Double
    
    init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

struct Color: CustomStringConvertible {
    var description: String {
        return "R: \(self.red), G: \(self.green), B: \(self.blue)"
    }
    
    static let white = Color(red: 0, green: 0, blue: 0)
    
    var red: Double
    var green: Double
    var blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(red: Int, green: Int, blue: Int) {
        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
    }
}

enum Alpha: Int, CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
    
    case one = 1
    case two
    case three
    case four
    case five
    case seven
    case eight
    case nine
    case ten
    
    init(value: Int) {
        switch value {
        case value where value <= 10 && value >= 1:
            self = Alpha(rawValue: value)!
        default:
            self = Alpha.ten
        }
    }
}
