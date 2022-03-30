//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/30.
//

import Foundation
import UIKit

class BackgroundColor: CustomStringConvertible {
    
    private var red: Int = 0
    private var green: Int = 0
    private var blue: Int = 0
    
    init(R: Int, G: Int, B: Int) {
        red = adjustColorValue(value: R)
        green = adjustColorValue(value: G)
        blue = adjustColorValue(value: B)
    }
    
    // Factory Method 방법
    static func randomColor() -> BackgroundColor {
        let r = Int.random(in: 0...255)
        let g = Int.random(in: 0...255)
        let b = Int.random(in: 0...255)
        return BackgroundColor(R: r, G: g, B: b)
    }
    
    static func rColor() -> BackgroundColor {
        return BackgroundColor(R: 255, G: 0, B: 0)
    }
    
    static func gColor() -> BackgroundColor {
        return BackgroundColor(R: 0, G: 255, B: 0)
    }
    
    static func bColor() -> BackgroundColor {
        return BackgroundColor(R: 0, G: 0, B: 255)
    }
    
    func adjustColorValue(value: Int) -> Int {
        if value < 0 { return 0 }
        else if value > 255 { return 255 }
        return value
    }
    
    var description: String {
        return "R: \(red), G: \(green), B: \(blue)"
    }
}

