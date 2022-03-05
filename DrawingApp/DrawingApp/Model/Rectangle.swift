//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

import UIKit

class Rectangle:CustomStringConvertible {
    var description: String {
        return "\(id), \(origin), \(size),\(backGroundColor), \(alpha)"
    }
    
    let id:ID
    let origin:Point
    let size:Size
    var backGroundColor:RGB
    var alpha:Alpha
    
    init(id:ID,origin:Point,size:Size,backGroundColor:RGB, alpha:Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.backGroundColor = backGroundColor
        self.alpha = alpha
    }
    

    func backgroundColor() -> UIColor{
        let red = backGroundColor.red
        let green = backGroundColor.green
        let blue = backGroundColor.blue
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha.value))
    }
}

