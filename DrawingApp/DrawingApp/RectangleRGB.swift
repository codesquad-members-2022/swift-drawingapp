//
//  Color.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct RectangleRGB{
    private var r: Int
    private var g: Int
    private var b: Int
    
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

extension RectangleRGB: CustomStringConvertible{
    var description: String {
        return "R:\(r), G:\(g), B:\(b)"
    }
}
