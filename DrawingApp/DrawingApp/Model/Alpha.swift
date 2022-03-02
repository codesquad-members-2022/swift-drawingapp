//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

enum Alpha: Double {
    case level1 = 0.1
    case level2 = 0.2
    case level3 = 0.3
    case level4 = 0.4
    case level5 = 0.5
    case level6 = 0.6
    case level7 = 0.7
    case level8 = 0.8
    case level9 = 0.9
    case level10 = 1.0
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
}

extension Alpha: CaseIterable {
    static var random: Alpha {
        var shuffledAllCases = Alpha.allCases.shuffled()
        return shuffledAllCases.removeLast()
    }
}
