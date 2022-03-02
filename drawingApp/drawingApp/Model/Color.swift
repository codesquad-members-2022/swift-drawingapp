//
//  Color.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
//Color (RGB) 타입 정의
struct Color : CustomStringConvertible {
    let red : Double = 0
    let green : Double = 0
    let blue : Double = 0
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
}
