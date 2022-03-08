//
//  Color.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct ColorRGB{
    private(set) var r: Int{
        didSet{
            if 0 > r && r > 255{
                r = 0
            }
        }
    }
    private(set) var g: Int{
        didSet{
            if 0 > g && g > 255 {
                g = 0
            }
        }
    }
    private(set) var b: Int{
        didSet{
            if 0 > b && b > 255 {
                b = 0
            }
        }
    }
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
