//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct BackgroundColor {
    let r: Double
    let g: Double
    let b: Double
    
    init(r: Int, g: Int, b: Int, min: Int = 0, max: Int = 255) {
        var colors = [Double(r), Double(g), Double(b)]
        let scale = Double(255) / Double(max)
        let possibleColorValues = (min...max).map {
            Double($0) * scale
        }
        colors.enumerated().forEach {
            if $0.element > Double(max) {
                colors[$0.offset] = 255.0
            } else if $0.element < Double(min) {
                colors[$0.offset] = 0.0
            } else {
                colors[$0.offset] = possibleColorValues[Int($0.element)]
            }
        }
        self.r = colors[0]
        self.g = colors[1]
        self.b = colors[2]
    }

}

extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "(R: \(r), G: \(g), B: \(b)"
    }
}
