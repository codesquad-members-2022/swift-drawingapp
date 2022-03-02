//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Rectangle: Factory {
    
    private let id: String
    private let size: Size
    private let point: Point
    private let backGroundColor: BackgroundColor
    private let alpha: Alpha
    
    func RequestCreateRectangle() -> Rectangle {
        let ractangle = self.createRectangle()
        return ractangle
    }
    
    init(id: String, size: Size, point: Point, backGroundColor: BackgroundColor, alpha: Alpha) {
        self.id = id
        self.size = size
        self.point = point
        self.backGroundColor = backGroundColor
        self.alpha = alpha
    }
}

