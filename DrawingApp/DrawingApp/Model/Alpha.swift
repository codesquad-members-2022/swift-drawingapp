//
//  Alpha.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

enum Alpha: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case seven
    case eight
    case nine
    case ten
    
    init(value: Int) {
        switch value {
        case value where value <= 10 && value >= 1:
            self = Alpha(rawValue: value)!
        default:
            self = Alpha.ten
        }
    }
}

extension Alpha: CustomStringConvertible, CaseIterable {
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
    
    func randomElement() -> Self {
        let element = Self.allCases.randomElement() ?? .ten
        return element
    }
}
