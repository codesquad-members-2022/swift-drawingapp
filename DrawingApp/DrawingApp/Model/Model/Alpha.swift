//
//  Alpha.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

struct Alpha: CustomStringConvertible {
    var value: Float
    
    init?(value: Float) {
        guard 0 <= value, value <= 10 else { return nil }
        
        self.value = value / 10
    }
    
    var description: String {
        "Alpha: \(value)"
    }
}
