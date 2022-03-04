//
//  Size.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

struct Size {
    private(set) var width: Double
    private(set) var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension Size {
    enum Range {
        static let lower = 0.0
        static let upper = 100.0
    }
}

extension Size: CustomStringConvertible {
    var description: String {
        return "W: \(self.width), H: \(self.height)"
    }
}
