//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

import UIKit

class Rectangle:CustomStringConvertible {
    var description: String {
        return "\(id), \(origin), \(size),\(rgb), \(alpha)"
    }
    
    let id:ID
    let origin:Point
    let size:Size
    var rgb:RGB
    var alpha:Alpha
    
    init(id:ID,origin:Point,size:Size,backGroundColor:RGB, alpha:Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.rgb = backGroundColor
        self.alpha = alpha
    }
    
}

