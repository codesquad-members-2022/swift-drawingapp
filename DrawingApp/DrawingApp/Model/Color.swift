//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class Color {
    private let red: Int
    private let green: Int
    private let blue: Int
    private let rgbMin = 0
    private let rgbMax = 255
    
    init(r: Int, g: Int, b: Int) {
        
        var rgbArray = [r, g, b]
        for index in rgbArray.indices {
            if rgbArray[index] < rgbMin {
                rgbArray[index] = rgbMin
            }
            if rgbArray[index] > rgbMax {
                rgbArray[index] = rgbMax
            }
        }
        
        self.red = rgbArray[0]
        self.green = rgbArray[1]
        self.blue = rgbArray[2]
    }
    
    
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R:\(self.red), G:\(self.green), B:\(self.blue)"
    }
}

