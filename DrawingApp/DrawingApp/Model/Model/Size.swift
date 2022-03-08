//
//  Size.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

struct Size: CustomStringConvertible {
    let width: Double
    let height: Double
    
    var description: String {
        "W\(width), H\(height)"
    }
    
    static func standard() -> Size {
        return Size(width: 150.0, height: 120.0)
    }
}
