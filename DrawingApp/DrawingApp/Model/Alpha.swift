//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

enum Alpha: Double {
    case level1
    case level2
    case level3
    case level4
    case level5
    case level6
    case level7
    case level8
    case level9
    case level10
    
    var value: Double {
        switch(self) {
        case .level1:
            return 0.1
        case .level2:
            return 0.2
        case .level3:
            return 0.3
        case .level4:
            return 0.4
        case .level5:
            return 0.5
        case .level6:
            return 0.6
        case .level7:
            return 0.7
        case .level8:
            return 0.8
        case .level9:
            return 0.9
        case .level10:
            return 1.0
        }
    }
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.value)"
    }
}

extension Alpha: CaseIterable {
    static var random: Alpha {
        var shuffledAllCases = Alpha.allCases.shuffled()
        return shuffledAllCases.removeLast()
    }
}
