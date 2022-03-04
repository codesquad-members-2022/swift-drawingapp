//
//  ColorFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/04.
//

import Foundation

enum ColorFactory: TypeBuilder {
    typealias T = Color
    
    static func makeType() -> Color {
        let range = Color.range
        let red = Double.random(in: range).rounded()
        let green = Double.random(in: range).rounded()
        let blue = Double.random(in: range).rounded()
        
        return Color(red: red, green: green, blue: blue) ?? .white
    }
}
