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
    
    init?(_ value: Int) {
        guard Alpha.min <= value, value <= Alpha.max else { return nil }
        
        self.value = Float(value) / 10.0
    }
    
    init?(_ value: Float) {
        guard Float(Alpha.min) <= value, value <= Float(Alpha.max) else { return nil }
        
        self.value = value / 10.0
    }
    
    static func random() -> Alpha {
        return Alpha(Int.random(in: 3...10))!
    }
    
    var description: String {
        "Alpha: \(value)"
    }
}
