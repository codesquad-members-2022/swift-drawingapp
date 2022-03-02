//
//  Color.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Color {
    private var red : Int
    private var green : Int
    private var blue : Int
    
    init(red: Int, green: Int, blue: Int){
        let inRange : (Int) -> Int = { (color) in
            switch color {
            case ...0:
                return 0
            case 255...:
                return 255
            default:
                return color
            }
        }
        self.red = inRange(red)
        self.green = inRange(green)
        self.blue = inRange(blue)
    }
}
extension Color : CustomStringConvertible {
    var description: String {
        return "R:\(self.red), G:\(self.green), B:\(self.blue)"
    }
}
