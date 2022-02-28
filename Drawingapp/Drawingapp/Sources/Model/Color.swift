//
//  Color.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Color: CustomStringConvertible {
    let r: Int
    let g: Int
    let b: Int
    
    init(r: Int = 0, g: Int = 0, b: Int = 0) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    var description: String {
        "( r: \(r), g: \(b), b: \(b) )"
    }
}

extension Color {
    static var black = Color(r: 0, g: 0, b: 0)
}
