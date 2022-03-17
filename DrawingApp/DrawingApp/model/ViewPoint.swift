//
//  ViewPoint.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct ViewPoint: Equatable, Hashable{
    let x: Int
    let y: Int

    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}
extension ViewPoint: CustomStringConvertible{
    var description: String {
        return "x:\(x), y:\(y)"
    }
}
extension ViewPoint: ViewPointMakeable{
    static func randomPoint() -> ViewPoint{
        let xMaxValue = 470
        let yMaxValue = 860
        let xRandomValue = Int.random(in: 1 ..< xMaxValue)
        let yRandomValue = Int.random(in: 1 ..< yMaxValue)
        return ViewPoint(x: xRandomValue, y: yRandomValue)
    }
}

protocol ViewPointMakeable{
    static func randomPoint() -> ViewPoint
}
