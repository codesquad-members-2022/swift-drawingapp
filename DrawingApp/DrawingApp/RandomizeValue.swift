//
//  RandomizeValue.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/01.
//

import Foundation

class RandomizeValue {
    func randomDouble(from: Double, to: Double) -> Double {
        guard from <= to else { return 0.0 }
        return Double.random(in: from...to)
    }
}
