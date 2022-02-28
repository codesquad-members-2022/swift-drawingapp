//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct BackgroundColor {
    private var r: Int
    private var g: Int
    private var b: Int
    private var alpha: Alpha
    
    init(r: Int, g: Int, b: Int, alpha: Int) {
        self.r = r
        self.g = g
        self.b = b
        self.alpha = Alpha(rawValue: alpha) ?? .one
    }
    
    enum Alpha: Int, CustomStringConvertible {
        case one = 1, two, three, four, five
        case six, seven, eight, nine, ten
        
        var description: String {
            return "Alpha: \(self.rawValue)"
        }
    }
}

extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "(R: \(r), G: \(g), B: \(b), \(alpha)"
    }
}
