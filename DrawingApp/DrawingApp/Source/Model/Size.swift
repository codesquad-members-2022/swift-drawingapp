//
//  Size.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/29.
//

import Foundation

class Size {
    private(set) var width: Double
    private(set) var height: Double
    
    init(width:Double, height:Double) {
        self.width = width
        self.height = height
    }
    
    static func randomSize() -> Size {
        let randomWidth = Double.random(in: 50.0...200.0)
        let randomHeight = Double.random(in: 50.0...200.0)
        return Size(width: randomWidth, height: randomHeight)
    }
}

extension Size: CustomStringConvertible {
    var description: String {
        return "Size: W = \(self.width), H = \(self.height)"
    }
}
