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
    
    init?(red: Int, green: Int, blue: Int){
        var isColorAble : Bool {
            return 0...255 ~= red &&
                   0...255 ~= green &&
                   0...255 ~= blue
        }
        guard isColorAble else{
            return nil
        }
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
