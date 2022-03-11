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
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha:\(self.rawValue)"
    }
}
