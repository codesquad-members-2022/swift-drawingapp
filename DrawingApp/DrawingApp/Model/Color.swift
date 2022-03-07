//
//  Color.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Color {
    var red : Double
    var green : Double
    var blue : Double
    
    static let colorRange = 0...255
    
    init? (red: Int, green: Int, blue: Int){
        guard Color.colorRange ~= red && Color.colorRange ~= green && Color.colorRange ~= blue else {return nil}
        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
    }
}
extension Color : CustomStringConvertible {
    var description: String {
        return "R:\(self.red), G:\(self.green), B:\(self.blue)"
    }
}
