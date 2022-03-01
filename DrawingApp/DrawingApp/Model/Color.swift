//
//  Color.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

struct Color {
    private var red: Double
    private var green: Double
    private var blue: Double
    private var alpha: Alpha
    
    init(red: Double, green: Double, blue: Double, alpha: Alpha) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R: \(self.red), G: \(self.green) B: \(self.blue), \(self.alpha)"
    }
}
