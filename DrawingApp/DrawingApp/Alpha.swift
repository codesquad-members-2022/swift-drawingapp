//
//  Alpha.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/03.
//

import Foundation

enum Alpha: Int, CustomStringConvertible, CaseIterable{
    
    case transparent = 1 , two, three, four, five, six, seven, eight, nine, opaque
    
    var description: String {
        return "Alpha : \(self.rawValue)"
    }
    
    static func randomAlpha() -> Alpha {
        return Alpha.allCases.randomElement()!
    }
}
