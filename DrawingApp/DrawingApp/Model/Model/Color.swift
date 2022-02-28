//
//  Color.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation

struct Color {
    var red: Int
    var green: Int
    var blue: Int
    var alpha: Int
    
    init?(r red: Int, g green: Int, b blue: Int, a alpha: Int) {
        guard red >= 0, red <= 255, green >= 0, green <= 255, blue >= 0, blue <= 255, alpha >= 0, alpha <= 10 else { return nil }
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}
