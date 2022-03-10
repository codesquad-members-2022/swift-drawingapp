//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

struct Color {
    private let red: Int
    private let green: Int
    private let blue: Int
    
    init(r: Int, g: Int, b: Int) {
        self.red = Int.random(in: 0...255)
        self.green = Int.random(in: 0...255)
        self.blue = Int.random(in: 0...255)
    }
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R:\(self.red), G:\(self.green), B:\(self.blue)"
    }
}

