//
//  Color.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct SquareColor{
    private var red: Int
    private var green: Int
    private var blue: Int
    private var alpha: Int
    
    init(red: Int, green: Int, blue: Int, alpha: Int) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}
extension SquareColor: CustomStringConvertible{
    var description: String {
        return "R:\(red), G:\(green), B:\(blue), Alpha\(alpha)"
    }
}
