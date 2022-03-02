//
//  Color.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

struct Color {
    static let black = Color(red: 0, green: 0, blue: 0)
    static let red = Color(red: 255, green: 0, blue: 0)
    static let green = Color(red: 0, green: 255, blue: 0)
    static let blue = Color(red: 0, green: 0, blue: 255)
    static let white = Color(red: 255, green: 255, blue: 255)
    
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Alpha
    
    init(red: Double, green: Double, blue: Double, alpha: Alpha = .opaque) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension Color: CustomStringConvertible, Equatable {
    var description: String {
        return "R: \(self.red), G: \(self.green), B: \(self.blue), Alph: \(self.alpha)"
    }
}
