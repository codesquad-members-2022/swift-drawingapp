//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Factory {
    
    func createId() -> String {
        let id = "abcdefghijklmnopqrstuvwxyz0123456789"
        let length = 9
        var count = 0
        var newId = ""

        for i in 0..<length {
            newId += String(id.shuffled()[i])
            count += 1
            if count % 3 == 0 {
                newId += "-"
            }
        }
        newId.removeLast()
        
        return newId
    }
    
    func createSize() -> Size {
        let size = Size(width: 150, height: 120)
        return size
    }
    
    func createPoint() -> Point {
        let point = Point(x: 0, y: 0)
        return point
    }
    
    func createColor() -> BackgroundColor {
        let color = BackgroundColor(r: Int.random(in: 0...255), g: Int.random(in: 0...255), b: Int.random(in: 0...255))
        return color
    }
    
    func createAlpha() -> Alpha {
        let alpha = Alpha.allCases.shuffled()[0]
        return alpha
    }
    
    func createRectangle() -> Rectangle {
        let ractangle = Rectangle(id: createId(), size: createSize(), point: createPoint(), backGroundColor: createColor(), alpha: createAlpha())
        return ractangle
    }
    
}

extension Factory: CustomStringConvertible {
    var description: String {
        return "(\(createId())), \(createPoint()), \(createSize()), \(createColor()), Alpha: \(createAlpha())"
    }
}
