//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class Rectangle {
    
    var identity:String
    var origin:Point
    var size:Size
    var backGroundColor:RGB
    var alpha:Alpha
    
    
    init(id:String,origin:Point,size:Size,backGroundColor:RGB, alpha:Alpha) {
        self.identity = id
        self.origin = origin
        self.size = size
        self.backGroundColor = backGroundColor
        self.alpha = alpha
    }
}


