//
//  RandomValue.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation
import os

class CustomViewFactory{
    
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
    
    private func makeRandomPoint() -> ViewPoint{
        let x = randomValue(property: .x)
        let y = randomValue(property: .y) + 44
        return ViewPoint(x: x, y: y)
    }
    
    private func makeRandomRectangle() -> Rectangle{
        let size = ViewSize(width: 150, height: 120)
        return Rectangle(uniqueId: makeUiniqueId(), color: makeRandomColor(), point: makeRandomPoint(), size: size, alpha: 1.0)
    }
    
    private func makeRandomColor() -> ColorRGB{
        let r = randomValue(property: .rgbRange)
        let b = randomValue(property: .rgbRange)
        let g = randomValue(property: .rgbRange)
        return ColorRGB(r: r, g: g, b: b)
    }
    
    private func makeRandomPhoto(imageData: Data) -> Photo{
        let size = ViewSize(width: 150, height: 150)
        return Photo(imageData: imageData, uniqueId: makeUiniqueId(), point: makeRandomPoint(), size: size, alpha: 1.0)
    }
}

extension CustomViewFactory: CustomViewFactoryResponse{
    func randomRectangle() -> RectangleMutable {
        return makeRandomRectangle()
    }
    
    func randomRGBColor() -> RGBColorMutable {
        return makeRandomColor()
    }
    
    func randomPhoto(imageData: Data) -> PhotoMutable{
        return makeRandomPhoto(imageData: imageData)
    }
}

protocol RectangleMutable{
    func getRandomRectangle() -> Rectangle
}

protocol RGBColorMutable{
    func getRandomColorRGb() -> ColorRGB
}

protocol PhotoMutable{
    func getRandomPhoto() -> Photo
}

enum RandomMax: Int{
    case x = 470
    case y = 860
    case rgbRange = 255
    
    var randomValue: Int{
        return Int.random(in: 1 ..< self.rawValue)
    }
}
