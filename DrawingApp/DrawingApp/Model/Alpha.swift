//
//  Alpha.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

protocol AlphaBuilder {
    init(_ value: Float)
}

enum Alpha: Float {
    case transparent = 0.1
    case two = 0.2
    case three = 0.3
    case four = 0.4
    case five = 0.5
    case six = 0.6
    case seven = 0.7
    case eight = 0.8
    case nine = 0.9
    case opaque = 1.0
    
    func convert<T: AlphaBuilder>(using Convertor: T.Type) -> T {
        return Convertor.init(self.rawValue)
    }
}

extension Alpha: CustomStringConvertible, CaseIterable {
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
    
    static func randomElement() -> Self {
        return Self.allCases.randomElement() ?? .opaque
    }
}
