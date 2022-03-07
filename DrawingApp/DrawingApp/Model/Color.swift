//
//  Color.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Color {
    var red : Int
    var green : Int
    var blue : Int
    
    static let colorRange = 0...255
    
    init? (red: Int, green: Int, blue: Int){
        guard Color.colorRange ~= red && Color.colorRange ~= green && Color.colorRange ~= blue else {return nil}
        self.red = red
        self.green = green
        self.blue = blue
    }
}
extension Color : CustomStringConvertible {
    var description: String {
        return "R:\(self.red), G:\(self.green), B:\(self.blue)"
    }
}
