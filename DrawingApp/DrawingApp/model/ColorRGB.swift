//
//  Color.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct ColorRGB: Equatable{
    private(set) var r: Int
    private(set) var g: Int
    private(set) var b: Int
    private var hexRGB: String{
        return String(format:"%02X", r) + String(format:"%02X", g) + String(format:"%02X", b)
    }
    
    init(r: Int, g: Int, b: Int) {
        self.r = r
        self.g = g
        self.b = b
    }
}

extension ColorRGB: CustomStringConvertible{
    var description: String {
        return "#\(hexRGB)"
    }
}
