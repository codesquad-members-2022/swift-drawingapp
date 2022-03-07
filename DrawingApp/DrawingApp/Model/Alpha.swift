//
//  Alpha.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation

enum Alpha: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    
    var opacity: Double {
        return Double(rawValue) / 10
    }
}


extension Alpha: CustomStringConvertible {
    var description: String {
        return "\(self.rawValue), Opacity: \(self.opacity)"
    }
}
