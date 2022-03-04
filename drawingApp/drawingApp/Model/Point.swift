//
//  Point.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
//Point (좌표) 타입 정의
struct Point : CustomStringConvertible {
    let x : Double
    let y : Double 
    var description: String {
        return "X:\(x.trim), Y:\(y.trim)"
    }
}

