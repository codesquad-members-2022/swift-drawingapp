//
//  Rectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

class Rectangle: CustomStringConvertible{
    private let id: String
    private let size: MySize
    private let point: MyPoint
    private let color: RGBColor
    private let alpha: Alpha
    
    var description: String{
        let description = "[\(id)] : (X: \(point.xValue()), Y:\(point.yValue())) / (W: \(size.widthValue()), H:\(size.heightValue())) / (R: \(color.redValue()), G: \(color.greenValue()), B: \(color.blueValue())) / Alpha: \(showAlpha())"
        return description
    }
    
    func showId() -> String{
        return id
    }
    
    func showSize() -> [Double]{
        let size = [self.size.widthValue(), self.size.heightValue()]
        return size
    }
    
    func showPoint() -> [Double]{
        let point = [self.point.xValue(),self.point.yValue()]
        return point
    }
    
    func showColor() -> [Double]{
        let rgb = [color.redValue() / 255, color.greenValue() / 255, color.blueValue() / 255]
        return rgb
    }
    
    func showAlpha() -> Double{
        return alpha.showValue()
    }
    
    init(id: String, size: MySize, point: MyPoint, color: RGBColor, alpha: Alpha){
        self.id = id
        self.size = size
        self.point = point
        self.color = color
        self.alpha = alpha
    }
}

extension String{
    static func makeRectangleID() -> String{
        let alphabet: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        var name: [String] = []
        
        for num in 0..<11{
            guard let randomString = alphabet.randomElement() else{
                break
            }
            
            if num == 3 || num == 7{
                name.append("-")
            } else{
                name.append(randomString)
            }
        }
        
        return name.joined()
    }
}
