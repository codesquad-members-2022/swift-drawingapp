//
//  Size.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class Size:CustomStringConvertible {
    var description: String {
        "W\(width), H\(height)"
    }
    
    private var width:Double
    private var height:Double
    
    init(width:Double, height:Double) {
        self.width = width
        self.height = height
    }
    
}
