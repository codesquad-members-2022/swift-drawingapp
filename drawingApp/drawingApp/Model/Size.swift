//
//  Size.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
//Size 타입 정의
struct Size : CustomStringConvertible {
    let width : Double
    let height : Double
    var description: String {
        return "W\(width), H\(height)"
    }
}
