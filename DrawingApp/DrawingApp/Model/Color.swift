//
//  Color.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

struct Color: ColorBuildable {
    static let range = 0.0...255.0
    
    static let black = Color(red: 0, green: 0, blue: 0)
    static let red = Color(red: 255, green: 0, blue: 0)
    static let green = Color(red: 0, green: 255, blue: 0)
    static let blue = Color(red: 0, green: 0, blue: 255)
    static let white = Color(red: 255, green: 255, blue: 255)
    
    let red: Double
    let green: Double
    let blue: Double
    
    private static func isValid(value: Double) -> Bool {
        return Color.range.contains(value)
    }
    
    private static func isValid(value: Int) -> Bool {
        return Color.range.contains(Double(value))
    }
    
    // MARK: - Initialisers
    private init(red: Int, green: Int, blue: Int) {
         guard Self.isValid(value: red) && Self.isValid(value: green) && Self.isValid(value: blue) else {
            self = .white
            return
        }
        
        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
    }
    
    init?(red: Double, green: Double, blue: Double) {
        if !Self.isValid(value: red) || !Self.isValid(value: green) || !Self.isValid(value: blue) {
            return nil
        }
            
        self.red = red
        self.green = green
        self.blue = blue
    }    
}

extension Color: CustomStringConvertible, Equatable {
    var description: String {
        return "R: \(self.red), G: \(self.green), B: \(self.blue)"
    }
}
