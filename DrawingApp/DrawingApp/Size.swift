//
//  Size.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct Size {
    private var width: Double
    private var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension Size: CustomStringConvertible {
    var description: String {
        return "H\(height), W\(width)"
    }
}
