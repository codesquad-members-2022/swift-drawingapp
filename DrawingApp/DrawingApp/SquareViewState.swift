//
//  SquareViewInfo.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct SquareViewState{
    let red: Int
    let green: Int
    let blue: Int
    let uniqueId: String
    let x: Int
    let y: Int
    let width: Int
    let height: Int
    let alpha: Int
}
extension SquareViewState: CustomStringConvertible{
    var description: String {
        return "(\(uniqueId)) X:\(x),Y:\(y), W\(width), H\(height) R:\(red), G:\(green), B:\(blue)"
    }
}
