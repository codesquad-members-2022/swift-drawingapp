//
//  Color.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

struct Color {
    static let range = UInt8.min...UInt8.max
    
    static let black = Color(red: 0, green: 0, blue: 0)
    static let red = Color(red: 255, green: 0, blue: 0)
    static let green = Color(red: 0, green: 255, blue: 0)
    static let blue = Color(red: 0, green: 0, blue: 255)
    static let white = Color(red: 255, green: 255, blue: 255)
    
    static func toHexString(_ color: Self) -> String {
        let RGB = Int(color.red * 255) << 16 | Int(color.green * 255) << 8 | Int(color.blue * 255)
        return String(format:"#%06x", RGB).uppercased()
    }
    
    let red: Double
    let green: Double
    let blue: Double
    
    // MARK: - Initialisers
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
    }
}

extension Color: CustomStringConvertible, Equatable {
    var description: String {
        return "R: \(self.red), G: \(self.green), B: \(self.blue)"
    }
}
