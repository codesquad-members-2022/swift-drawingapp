//
//  Size.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/02.
//

import Foundation

struct Size: CustomStringConvertible{

    private var width: Double
    private var height: Double
    
    init(width: Double, height: Double){
        self.width = width
        self.height = height
    }
    
    static func randomSize() -> Size {
        let randomWidth = Double.random(in: 100.0...200.0)
        let randomHeight = Double.random(in: 100.0...200.0)
        return Size(width: randomWidth, height: randomHeight)
    }
    
    var description: String {
        return "Width : \(width), Height: \(height)"
    }
}
