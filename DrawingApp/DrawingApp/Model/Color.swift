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
    
    enum Range {
        static let min = 0
        static let max = 255
    }
    
    init (red: Int, green: Int, blue: Int){
        self.red = Double(red)/255
        self.green = Double(green)/255
        self.blue = Double(blue)/255
    }
}
extension Color : CustomStringConvertible {
    var description: String {
        return "R:\(self.red), G:\(self.green), B:\(self.blue)"
    }
}
