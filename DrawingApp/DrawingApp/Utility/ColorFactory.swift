//
//  ColorFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/04.
//

import Foundation

enum ColorFactory: TypeBuilder {
    typealias T = Color
    
    static func makeTypeRandomly() -> Color {
        let range = Color.range
        let red = UInt8.random(in: range)
        let green = UInt8.random(in: range)
        let blue = UInt8.random(in: range)
        
        return Color(red: red, green: green, blue: blue)
    }
}
