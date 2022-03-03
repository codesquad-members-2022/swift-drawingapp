//
//  Alpha.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

struct Alpha: CustomStringConvertible {
    static let max = 10
    static let min = 0
    
    let value: Float
    
    init?(value: Int) {
        guard 0 <= Alpha.min, value <= Alpha.max else { return nil }
        
        self.value = Float(value) / 10.0
    }
    
    var description: String {
        "Alpha: \(value)"
    }
}
