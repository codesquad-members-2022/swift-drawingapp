//
//  Size.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Size: CustomStringConvertible {
    let width: Double
    let height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    var description: String {
        "( W: \(width), H: \(height) )"
    }
}

extension Size {
    static func make(width: Double, height: Double) -> Size {
        Size(width: width, height: height)
    }
}
