//
//  Size.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

struct Size {
    private let width: Double
    private let height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension Size: CustomStringConvertible {
    var description: String {
        return "W:\(self.width), H:\(self.height)"
    }
}
