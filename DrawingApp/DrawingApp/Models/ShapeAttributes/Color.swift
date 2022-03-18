//
//  Color.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import UIKit

class Color {
    
    private(set) var red: Double
    private(set) var green: Double
    private(set) var blue: Double
    
    init(validRed: Double, validGreen: Double, validBlue: Double) {
        self.red = validRed
        self.green = validGreen
        self.blue = validBlue
    }
    
    convenience init?(red: Double, green: Double, blue: Double) {
        if red < Range.lower || red > Range.upper ||
            green < Range.lower || green > Range.upper ||
            blue < Range.lower || blue > Range.upper
        {
            return nil
        }
        
        self.init(validRed: red, validGreen: green, validBlue: blue)
    }
    
    func toUIColor() -> UIColor {
        let red = red / Color.Range.upper
        let green = green / Color.Range.upper
        let blue = blue / Color.Range.upper
        let alpha = Color.Alpha.default
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    enum Range {
        static let lower = 0.0
        static let upper = 255.0
    }
    
    enum Alpha {
        static let `default` = 1.0
    }
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R: \(self.red), G: \(self.green) B: \(self.blue)"
    }
}
