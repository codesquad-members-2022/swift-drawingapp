//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Color {
    static let min = 0
    static let max = 255
    
    var r: Int { checkRange(number: checkR) }
    var g: Int { checkRange(number: checkG) }
    var b: Int { checkRange(number: checkB) }
    
    private let checkR: Int
    private let checkG: Int
    private let checkB: Int
    
    func checkRange(number: Int) -> Int {
        if number < Color.min {
            return Color.min
        } else if number > Color.max {
            return Color.max
        } else {
            return number
        }
    }
    
    init(r: Int, g: Int, b: Int) {
        self.checkR = r
        self.checkG = g
        self.checkB = b
    }
    
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R: \(r), G: \(g), b: \(b)"
    }
}
