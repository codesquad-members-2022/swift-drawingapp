//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/02.
//

import Foundation

struct Alpha {
    let value: Double
    
    init(opacityLevel: Int, min: Int = 1, max: Int = 10) {
        if opacityLevel > max {
            self.value = 1.0
        } else if opacityLevel < min {
            self.value = 0.1
        } else {
            let possibleAlphaValues = [0] + (min...max).map {
                Double($0) / Double(max)
            }
            self.value = possibleAlphaValues[opacityLevel]
        }

    }
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha: \(value)"
    }
}
