//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

struct BackgroundColor: Equatable {
    let r: UInt8
    let g: UInt8
    let b: UInt8
    static let possibleColorValues = UInt8(0)...UInt8(255)
    var hexCode: String {
        let hexR = String(Int(r), radix: 16).uppercased()
        let hexG = String(Int(g), radix: 16).uppercased()
        let hexB = String(Int(b), radix: 16).uppercased()
        
        return "#\(hexR)\(hexG)\(hexB)"
    }
    
    init(r: UInt8, g: UInt8, b: UInt8) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    static func random() -> BackgroundColor {
        let randomR = UInt8.random(in: possibleColorValues)
        let randomG = UInt8.random(in: possibleColorValues)
        let randomB = UInt8.random(in: possibleColorValues)
        
        return BackgroundColor(r: randomR, g: randomG, b: randomB)
    }

}

extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "(R: \(r), G: \(g), B: \(b)"
    }
}
