//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct BackgroundColor {
    let r: Double
    let g: Double
    let b: Double
    static let possibleColorValues = 0...255
    var hexCode: String {
        let hexR = String(Int(r), radix: 16).uppercased()
        let hexG = String(Int(g), radix: 16).uppercased()
        let hexB = String(Int(b), radix: 16).uppercased()
        
        return "#\(hexR)\(hexG)\(hexB)"
    }
    
    init?(r: Int, g: Int, b: Int) {
        let colors = [Double(r), Double(g), Double(b)]
        let min = BackgroundColor.possibleColorValues.min() ?? 0
        let max = BackgroundColor.possibleColorValues.max() ?? 255
        
        for colorValue in colors {
            if colorValue > Double(max) || colorValue < Double(min){
                return nil
            }
        }
        
        self.r = colors[0]
        self.g = colors[1]
        self.b = colors[2]
    }

}

extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "(R: \(r), G: \(g), B: \(b)"
    }
}
