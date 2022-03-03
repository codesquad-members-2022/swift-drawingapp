//
//  Size.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Size {
    var width : Double
    var height : Double
    init(width: Double, height : Double) {
        self.width = width
        self.height = height
    }
}

extension Size : CustomStringConvertible {
    var description: String {
        return "W\(self.width), H\(self.height)"
    }
}
