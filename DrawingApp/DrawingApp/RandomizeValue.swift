//
//  RandomizeValue.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/01.
//

import Foundation

// 여러가지 값을 이용하여 랜덤 값을 추출하는 용도로 쓰기 위해 만든 클래스입니다.
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
