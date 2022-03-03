//
//  Size.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/03.
//

import Foundation

struct Size {
    let width: Double
    let height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    init(width: Int, height: Int) {
        self.width = Double(width)
        self.height = Double(height)
    }
    
    init(length: Double) {
        self.init(width: length, height: length)
    }
}
