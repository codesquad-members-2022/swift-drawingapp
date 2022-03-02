//
//  Size.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
//Size 타입 정의
struct Size : CustomStringConvertible {
    let width : Double = 0
    let height : Double = 0
    var description: String {
        return "W\(width), H\(height)"
    }
}
