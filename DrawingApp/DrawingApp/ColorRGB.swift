//
//  Color.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct ColorRGB{
    private var r: Int
    private var g: Int
    private var b: Int
    private var hexRGB: String{
        return String(format:"%02X", r) + String(format:"%02X", g) + String(format:"%02X", b)
    }
    
    init(r: Int, g: Int, b: Int) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    func rValue() -> Double{
        return Double(r)
    }
    
    func gValue() -> Double{
        return Double(g)
    }
    
    func bValue() -> Double{
        return Double(b)
    }
}

extension ColorRGB: CustomStringConvertible{
    var description: String {
        return "#\(hexRGB)"
    }
}
