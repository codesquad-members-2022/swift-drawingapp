//
//  Color.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/02.
//

import Foundation

struct Color: CustomStringConvertible{
    
    private var red: Int = 0
    private var green: Int = 0
    private var blue: Int = 0
    
    init(R: Int, G: Int, B: Int)  {
        red = R
        green = G
        blue = B
    }
    
    init() {
        red = Int.random(in: 0...255)
        green = Int.random(in: 0...255)
        blue = Int.random(in: 0...255)
    }
    
    var description: String {
        return "R : \(red), G: \(green), B: \(blue)"
    }
    
}
