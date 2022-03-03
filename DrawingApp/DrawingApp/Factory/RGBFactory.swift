//
//  RGBFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

final class RGBFactory {
    
    static func makeRandomRGB() -> RGB {
        let randomRed = Double.random(in: RGB.minValue...RGB.maxValue)
        let randomGreen = Double.random(in: RGB.minValue...RGB.maxValue)
        let randomBlue = Double.random(in: RGB.minValue...RGB.maxValue)
        
        return RGB(red: randomRed, green: randomGreen, blue: randomBlue)
    }
}
