//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct BackgroundColor {
    let r: Int
    let g: Int
    let b: Int
    
    init(r: Int, g: Int, b: Int) {
        let maxColorValue = 255
        let minColorValue = 0
        var colors = [r, g, b]
        colors.enumerated().forEach {
            if $0.element > maxColorValue {
                colors[$0.offset] = 255
            } else if $0.element < minColorValue {
                colors[$0.offset] = 0
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
