//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class Rectangle:CustomStringConvertible {
    var description: String {
        return "\(id), \(origin), \(size),\(backGroundColor), \(alpha)"
    }
    
    
    let id:ID
    let origin:Point
    let size:Size
    let backGroundColor:RGB
    let alpha:Alpha
    
    
    init(id:ID,origin:Point,size:Size,backGroundColor:RGB, alpha:Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.backGroundColor = backGroundColor
        self.alpha = alpha
    }
}

