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
        let red = UInt8.random(in: UInt8.min...UInt8.max)
        let green = UInt8.random(in: UInt8.min...UInt8.max)
        let blue = UInt8.random(in: UInt8.min...UInt8.max)
        
        return Color(red: red, green: green, blue: blue)
    }
}
