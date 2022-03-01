//
//  RandomFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

import UIKit

final class RandomFactory {
    
    static func makeRandomRGB() -> RGB {
        let randomRed = Int.random(in: 0...255)
        let randomGreen = Int.random(in: 0...255)
        let randomBlue = Int.random(in: 0...255)
        
        let randomRGB = RGB(red: randomRed, green: randomGreen, blue: randomBlue)
        
        return randomRGB
    }
    
    static func makeRandomPoint() -> Point {
        let randomX = Double.random(in: 0...UIScreen.main.bounds.width)
        let randomY = Double.random(in: 0...UIScreen.main.bounds.height)
        let randomPoint = Point(x: randomX, y: randomY)
        return randomPoint
    }
    
    
    static func makeRandomAlpha() -> Alpha {
        let randomAlphaValue = Int.random(in: 0...10)
        let randomAlpha = Alpha(alpha: randomAlphaValue)
        
        return randomAlpha
    }
    
    static func makeRandomID() -> String {
        let randomIdElement0 = makeIdElements()
        let randomIdElement1 = makeIdElements()
        let randomIdElement2 = makeIdElements()
        
        let randomID = "(\(randomIdElement0)-\(randomIdElement1)-\(randomIdElement2))"
        
        return randomID
    }
    
    private static func makeIdElements() -> String {
        let idSource = "abcdefghijklmnopqrstu0123456789"
        var randomIdElement = ""
        for _ in 0...2 {
            randomIdElement.append(idSource.randomElement() ?? " ")
        }
        return randomIdElement
    }
}
