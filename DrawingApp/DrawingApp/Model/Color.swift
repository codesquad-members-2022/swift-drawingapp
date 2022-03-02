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
    
    init(red: Double, green: Double, blue: Double, alpha: Alpha) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

extension Color {
    enum Bound {
        static let lowwer = 0.0
        static let upper = 255.0
    }
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R: \(self.red), G: \(self.green) B: \(self.blue)"
    }
}
