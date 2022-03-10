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
    
    private(set) var value: Double
    
    init(value: Double) {
        self.value = value / 10
        
        if value < Alpha.min { self.value = Alpha.min }
        if value > Alpha.max { self.value = Alpha.max }
    }
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha: \(value)"
    }
}
