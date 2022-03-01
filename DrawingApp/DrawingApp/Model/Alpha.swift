//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

enum Alpha: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nin
    case ten
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
}

extension Alpha: CaseIterable {
    static var randomAlpha: Alpha {
        let range = (0..<Alpha.allCases.count)
        return Alpha.allCases[Int.random(in: range)]
    }
}
