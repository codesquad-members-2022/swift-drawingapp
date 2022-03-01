//
//  Size.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Size {
    
    private let width: Double
    private let height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
}

extension Size: CustomStringConvertible {
    var description: String {
        return "W: \(width), H: \(height)"
    }
}
