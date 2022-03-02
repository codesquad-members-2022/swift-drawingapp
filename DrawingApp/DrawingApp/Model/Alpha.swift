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
    
    func randomElement() -> Self {
        let element = Self.allCases.randomElement() ?? .opaque
        return element
    }
}
