//
//  Alpha.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

struct Alpha {
    
    static let min = 1.0
    static let max = 10.0
    
    var alpha: Double { checkRange(number: value) }
    
    private let value: Double
    
    func checkRange(number: Double) -> Double {
        if number < Alpha.min {
            return Alpha.min
        } else if number > Alpha.max {
            return Alpha.max
        } else {
            return number
        }
    }

    init(alpha: Double) {
        self.value = alpha / 10
    }
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha: \(value)"
    }
}
