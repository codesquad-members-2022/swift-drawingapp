//
//  RandomFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

final class RandomFactory {
    
    static func makeRandomRGBValue() -> RGB {
        let randomRed = Int.random(in: 0...255)
        let randomGreen = Int.random(in: 0...255)
        let randomBlue = Int.random(in: 0...255)
        
        let randomRGB = RGB(red: randomRed, green: randomGreen, blue: randomBlue)
        
        return randomRGB
    }
    
    static func makeRandomAlpha() -> Alpha {
        let randomAlphaValue = Int.random(in: 0...10)
        let randomAlpha = Alpha(alpha: randomAlphaValue)
        
        return randomAlpha
    }
    
    static func makeRandomID() -> String {
        var randomID = ""
        
        for _ in 0..<3 {
            randomID.append(makeIdElements(number:3))
            randomID.append("-")
        }
        
        return randomID
    }
    
    private static func makeIdElements(number:Int) -> String {
        let idSource = "abcdefghijklmnopqrstu0123456789"
        var idElements = ""
        
        for _ in 0..<number {
            idElements.append(idSource.randomElement() ?? " ")
        }
        
        return idElements
    }
}
