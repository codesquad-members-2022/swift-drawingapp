//
//  Size.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/04.
//

import Foundation

class Size {
    private(set) var width: Double
    private(set) var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}


extension Size: CustomStringConvertible {
    var description: String {
        return "W\(width), H\(height)"
    }
}
