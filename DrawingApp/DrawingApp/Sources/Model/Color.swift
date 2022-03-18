//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Color {
    static let min = 0.0
    static let max = 255.0
    
    private(set) var r: Double
    private(set) var g: Double
    private(set) var b: Double
    
    init(r: Double, g: Double, b: Double) {
        self.r = r
        self.g = g
        self.b = b
        
        if r <= Color.min { self.r = Color.min }; if r >= Color.max { self.r = Color.max }
        if g <= Color.min { self.g = Color.min }; if g >= Color.max { self.g = Color.max }
        if b <= Color.min { self.b = Color.min }; if b >= Color.max { self.b = Color.max }
    }
    
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R: \(r), G: \(g), b: \(b)"
    }
}
