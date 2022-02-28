//
//  Size.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class Size {
    private let width: Double
    private let height: Double
    private var size: Double {
        return width * height
    }
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}
