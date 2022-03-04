//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation

class BackgroundColor {
    private let red: Int
    private let green: Int
    private let blue: Int
    
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}


extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
}
