//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/02.
//

import Foundation

struct Alpha: Equatable {
    enum OpacityLevel: Double, CaseIterable {
        case one = 0.1, two = 0.2, three = 0.3, four = 0.4, five = 0.5
        case six = 0.6, seven = 0.7, eight = 0.8, nine = 0.9, ten = 1.0
    }
    let opacityLevel: OpacityLevel
    let value: Double
    
    init(opacityLevel: OpacityLevel) {
        self.opacityLevel = opacityLevel
        self.value = opacityLevel.rawValue
    }
    
    static func == (lhs: Alpha, rhs: Alpha) -> Bool {
        lhs.opacityLevel.rawValue == rhs.opacityLevel.rawValue
    }
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha: \(value)/ OpacityLevel: \(opacityLevel)"
    }
}
