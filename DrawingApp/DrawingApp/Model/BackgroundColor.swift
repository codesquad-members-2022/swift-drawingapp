//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct BackgroundColor: Equatable {
    let r: Int
    let g: Int
    let b: Int
    static let possibleColorValues = 0...255
    var hexCode: String {
        let hexR = String(Int(r), radix: 16).uppercased()
        let hexG = String(Int(g), radix: 16).uppercased()
        let hexB = String(Int(b), radix: 16).uppercased()
        
        return "#\(hexR)\(hexG)\(hexB)"
    }
    
    init?(r: Int, g: Int, b: Int) {
        let colorValues = [r, g, b]
        let min = BackgroundColor.possibleColorValues.min() ?? 0
        let max = BackgroundColor.possibleColorValues.max() ?? 255
        
        for colorValue in colorValues {
            if colorValue > max || colorValue < min {
                return nil
            }
        }
        
        self.r = colorValues[0]
        self.g = colorValues[1]
        self.b = colorValues[2]
    }

}

extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "(R: \(r), G: \(g), B: \(b)"
    }
}
