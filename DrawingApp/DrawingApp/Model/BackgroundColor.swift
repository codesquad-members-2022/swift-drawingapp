//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class BackgroundColor {
    
    private var r: Int
    private let g: Int
    private let b: Int
    
    init(r: Int, g: Int, b: Int) {
        self.r = r
        self.g = g
        self.b = b
    }
}

extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "R: \(r), G: \(g), b: \(b)"
    }
}
