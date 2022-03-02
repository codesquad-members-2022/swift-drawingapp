//
//  Alpha.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

enum Alpha: Int {
    case transparent = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case opaque
}

extension Alpha: CustomStringConvertible, CaseIterable {
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
    
    static func randomElement() -> Self {
        let index = Int.random(in: 0..<Self.allCases.count)
        return Self.allCases[index]
    }
}
