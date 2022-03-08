//
//  Alpha.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/08.
//

import Foundation

class Alpha {
    private let value: Int
    private let alphaMin = 1
    private let alphaMax = 10
    
    init(_ value: Int) {
        var adjustedValue = value
        if value < alphaMin {
            adjustedValue = alphaMin
        }
        if value > alphaMax {
            adjustedValue = alphaMax
        }
        self.value = adjustedValue
    }
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha:\(self.value)"
    }
}
