//
//  Color.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation
import UIKit

struct Color: CustomStringConvertible {
    let red: Float
    let green: Float
    let blue: Float
    let alpha: Float = 1
    
    init?(r red: Float, g green: Float, b blue: Float) {
        guard red >= 0, red <= 255, green >= 0, green <= 255, blue >= 0, blue <= 255 else { return nil }
        
        self.red = red / 255
        self.green = green / 255
        self.blue = blue / 255
    }
    
    var uiColor: UIColor {
        UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    var description: String {
        "R:\(red), G:\(green), B:\(blue)"
    }
}
