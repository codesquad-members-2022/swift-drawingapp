//
//  Alpha.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

protocol AlphaBuilder {
    init(_ value: Int)
}

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
    
    init?(rawValue: Float) {
        let value = Int(rawValue)
        guard let alpha = Self.init(rawValue: value) else {
            return nil
        }
        
        self = alpha
    }
    
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
