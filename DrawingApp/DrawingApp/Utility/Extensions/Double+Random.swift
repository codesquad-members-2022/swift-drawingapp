//
//  Double+Random.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/07.
//

import Foundation

extension Double {
    static func random(in range: ClosedRange<Double>, digits: Int) -> Double {
        let value = Double.random(in: range)
        let divisor = pow(10, Double(digits))
        return (value * divisor).rounded() / divisor
    }
}
