//
//  Size.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

struct Size: CustomStringConvertible {
    
    let width: Double
    let height: Double
    
    var description: String {
        "W: \(width), H: \(height)"
    }
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}
