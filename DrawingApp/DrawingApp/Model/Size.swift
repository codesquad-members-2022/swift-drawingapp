//
//  Size.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
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

extension Size {
    enum Bound {
        static let lowwer = 0.0
        static let upper = 100.0
    }
}

extension Size: CustomStringConvertible {
    var description: String {
        return "W: \(self.width), H: \(self.height)"
    }
}
