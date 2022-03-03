//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/03.
//

import Foundation


class RectangleFactory: RectangleCreator {
    
    func createColoredRectangle(size: Size, position: Point, color: Color, alpha: Alpha) -> Rectangle {
        let ID = createRandomStr()
        return Rectangle(ID: ID, size: size, position: position, backgroundColor: color, alpha: alpha)
    }
    
    func createRectangle(size: Size, position: Point) -> Rectangle {
        return createColoredRectangle(size: size, position: position, color: Color(), alpha: Alpha.allCases.randomElement()!)
    }
    
    func createRandomRectangle() -> Rectangle{
        return createColoredRectangle(size: Size(), position: Point(), color: Color(), alpha: Alpha.allCases.randomElement()!)
    }
    
    func createRectangle(x: Double, y: Double, width: Double, height: Double) -> Rectangle{
        let size =  Size(width: width, height: height)
        let position = Point(x: x, y: y)
        return createColoredRectangle(size: size, position: position, color: Color(), alpha: Alpha.allCases.randomElement()!)
    }
    
    
    func createRandomStr() -> String {
    
        let stringSet = "abcdefghijklmnopqrstuvwxyz1234567890"
        var randomString = ""
           for _ in 0..<9 {
               randomString.append(stringSet.randomElement() ?? " ")
           }
  
        randomString.insert("-", at: randomString.index(randomString.startIndex, offsetBy: 3))
        randomString.insert("-", at: randomString.index(randomString.startIndex, offsetBy: 7))

        return randomString
    }

    
}
