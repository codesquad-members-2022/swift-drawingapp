//
//  Alpha.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class Alpha:CustomStringConvertible {
    var description: String {
        "Alpha: \(alpha)"
    }
    
    private var alpha:Int
    
    init(alpha:Int) {
        self.alpha = alpha
    }
}
