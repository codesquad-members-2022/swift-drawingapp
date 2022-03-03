//
//  ColorFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/03.
//

import Foundation

class ColorFactory {
    func maker() -> Color {
        let colorValues = (0..<3).map{ _ in Int.random(in: 0...255) }
        return Color(r: colorValues[0], g: colorValues[1], b: colorValues[2])
    }
}
