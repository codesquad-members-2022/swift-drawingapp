//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

struct Color {
    private let red: Int
    private let green: Int
    private let blue: Int
    
    init(r: Int, g: Int, b: Int) {
        self.red = r
        self.green = g
        self.blue = b
    }
    
    func getRed() -> Int {
        return red
    }
    
    func getGreen() -> Int {
        return green
    }
    
    func getBlue() -> Int {
        return blue
    }
    
    static func generateRandomColor() -> Color {
        return Color(r: Int.random(in: 0...255), g: Int.random(in: 0...255), b: Int.random(in: 0...255))
    }
    
    static func convertCGValueToInt(red: Double, green: Double, blue: Double) -> Color {
        return Color(r: Int(round(red * 255)), g: Int(round(green * 255)), b: Int(round(blue * 255)))
    }
    
    static func convertRGBToHexColorCode(_ r: Int, _ g: Int, _ b: Int) -> String {
        var hexR = String(r, radix: 16).uppercased()
        var hexG = String(g, radix: 16).uppercased()
        var hexB = String(b, radix: 16).uppercased()
        if r < 16 {
            hexR = "0" + hexR
        }
        if g < 16 {
            hexG = "0" + hexG
        }
        if b < 16 {
            hexB = "0" + hexB
        }
        return "#" + hexR + hexG + hexB
    }
}

extension Color: CustomStringConvertible {
    var description: String {
        return "R:\(self.red), G:\(self.green), B:\(self.blue)"
    }
}

