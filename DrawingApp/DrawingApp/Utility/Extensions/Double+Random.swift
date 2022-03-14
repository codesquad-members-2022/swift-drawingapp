//
//  Double+Random.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/07.
//

import Foundation

extension Double {
    static func random(in range: ClosedRange<Self>, digits: Int) -> Self {
        let value = Self.random(in: range)
        return value.toFixed(digits: digits)
    }
    
    func toFixed(digits: Int) -> Self {
        let divisor = pow(10, Self.init(digits))
        return (self * divisor).rounded() / divisor
    }
}
