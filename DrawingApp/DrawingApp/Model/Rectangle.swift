//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Rectangle {
    
    private let id: String
    private let size: Size
    private let point: Point
    private let backGroundColor: BackgroundColor
    private let alpha: Alpha
    
    func createId() -> String {
        let length = 9
        var newId = id.createRandomString(length: length)
        newId.insert("-", at: id.index(id.startIndex, offsetBy: 3))
        newId.insert("-", at: id.index(id.startIndex, offsetBy: 6))
        
        return newId
    }
    
    init(id: String, size: Size, point: Point, backGroundColor: BackgroundColor, alpha: Alpha) {
        self.id = id
        self.size = size
        self.point = point
        self.backGroundColor = backGroundColor
        self.alpha = alpha

    }
}

extension String {
    
    func createRandomString(length: Int) -> String {
        let string = (0..<length).map { _ in self.randomElement()! }
        
        return String(string)
    }

}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(point.description), \(size.description), \(backGroundColor.description), Alpha: \(alpha)"
    }
}
