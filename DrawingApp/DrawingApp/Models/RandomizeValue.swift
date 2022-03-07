//
//  RandomizeValue.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/01.
//

import Foundation

/// 여러 타입의 랜덤 값을 추출할 수 있는 클래스입니다.
///
/// 필요에 따라 다른 인터페이스들이 추가될 수 있습니다.
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
