//
//  Size.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

    private let width: Double
    private let height: Double
    private var size: Double {
        return width * height
    }
struct Size {
    
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
