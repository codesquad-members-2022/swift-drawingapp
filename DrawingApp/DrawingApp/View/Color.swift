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
    
    init() {
        self.red = Int.random(in: 0...255)
        self.green = Int.random(in: 0...255)
        self.blue = Int.random(in: 0...255)
    }
}


extension Color: CustomStringConvertible {
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
}
