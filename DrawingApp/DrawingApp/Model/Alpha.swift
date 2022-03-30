//
//  Alpha.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/08.
//

import Foundation

enum Alpha: Int, Comparable {
    
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
    
    static func < (lhs: Alpha, rhs: Alpha) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func convertCGValueToInt(alpha: Double) -> Int {
        return Int(round(alpha * 10))
    }
    
    static func generateRandomAlpha() -> Alpha {
        return Alpha(rawValue: Int.random(in: one.rawValue...ten.rawValue))!
    }
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha:\(self.rawValue)"
    }
}
