//
//  Alpha.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

struct Alpha: CustomStringConvertible {
    var value: Float
    
    init?(value: Int) {
        guard 0 <= value, value <= 10 else { return nil }
        
        self.value = Float(value) / 10.0
    }
    
    var description: String {
        "Alpha: \(value)"
    }
}
