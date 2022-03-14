//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

enum Alpha: Int {
    
    case level1 = 1
    case level2
    case level3
    case level4
    case level5
    case level6
    case level7
    case level8
    case level9
    case level10
    
    static let minLevel = level1
    static let maxLevel = level10
    
    var value: Float {
        return Float(self.rawValue) / Float(Alpha.maxLevel.rawValue)
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
    
    var isMaxLevel: Bool {
        return self.rawValue == Alpha.maxLevel.rawValue
    }
    
    var isMinLevel: Bool {
        return self.rawValue == Alpha.minLevel.rawValue
    }
    
    var nextLevel: Alpha? {
        let alphaCases = Alpha.allCases
        
        guard let currentIndex = alphaCases.firstIndex(of: self) else { return nil }
        return alphaCases[alphaCases.index(after: currentIndex)]
    }
    
    var previousLevel: Alpha? {
        let alphaCases = Alpha.allCases
        
        guard let currentIndex = alphaCases.firstIndex(of: self) else { return nil }
        return alphaCases[alphaCases.index(before: currentIndex)]
    }
}
