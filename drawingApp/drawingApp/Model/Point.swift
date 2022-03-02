//
//  Point.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
//Point (좌표) 타입 정의
struct Point : CustomStringConvertible {
    let x : Double = 0
    let y : Double = 0
    var description: String {
        return "X:\(x), Y:\(y)"
    }
}
