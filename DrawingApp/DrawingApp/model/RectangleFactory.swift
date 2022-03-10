//
//  RandomValue.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation
import os

class RectangleFactory{
    
    private func makeUiniqueId() -> String{
        let allString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let uniqueStrings = (0 ..< 9).map{ _ in allString.randomElement() }
        var result: String = ""
        for (index, uniqueString) in uniqueStrings.enumerated(){
            if index % 3 == 0 && index != 0{
                result += "-"
            }
            guard let uniqueString = uniqueString?.description else {
                return ""
            }
            result += uniqueString.description
        }
        return result
    }
    
    private func randomValue(property: RandomMax) -> Int{
        return property.randomValue
    }
    
    private func makeRandomRectangle() -> Rectangle{
        let r = randomValue(property: .rgbRange)
        let b = randomValue(property: .rgbRange)
        let g = randomValue(property: .rgbRange)
        let x = randomValue(property: .x)
        let y = randomValue(property: .y) + 44
        let uniqueId = makeUiniqueId()
        let color = ColorRGB(r: r, g: g, b: b)
        let point = ViewPoint(x: x, y: y)
        let size = ViewSize(width: 150, height: 120)
        return Rectangle(uniqueId: uniqueId, color: color, point: point, size: size, alpha: 1.0)
    }
    
    private func makeRandomColor() -> ColorRGB{
        let r = randomValue(property: .rgbRange)
        let b = randomValue(property: .rgbRange)
        let g = randomValue(property: .rgbRange)
        return ColorRGB(r: r, g: g, b: b)
    }
}

extension RectangleFactory: RectangleFactoryResponse{
    func randomRectangle() -> Rectangle {
        return makeRandomRectangle()
    }
    
    func randomRGBColor() -> ColorRGB {
        return makeRandomColor()
    }
}

enum RandomMax: Int{
    case x = 470
    case y = 860
    case rgbRange = 255
    
    var randomValue: Int{
        return Int.random(in: 1 ..< self.rawValue)
    }
}
