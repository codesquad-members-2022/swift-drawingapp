//
//  RandomizeValue.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/01.
//

import Foundation

class RandomizeValue {
    func getDoubleRandom(from: Double, to: Double) -> Double {
        guard from <= to else { return 0.0 }
        return Double.random(in: from...to)
    }
    
    func getIntRandom(from: Int, to: Int) -> Int {
        guard from <= to else { return 0 }
        return Int.random(in: from...to)
    }
}
