//
//  RGB.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class RGB:CustomStringConvertible {
    var description: String {
        "R:\(red), G:\(green), B:\(blue)"
    }
    
    private var red:Int
    private var green:Int
    private var blue:Int
    
    init(red:Int,green:Int,blue:Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
}
