//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class Rectangle {
    private let id: String
    private let size: Size
    private let point: Point
    private let backgroundColor: (R: Int, G: Int, B: Int)
    private let alpha: Int
    
    init(id: String, width: Double, height: Double, x: Double, y: Double, backgroundColor: (R:Int, G: Int, B: Int), alpha: Int) {
        self.id = id
        size = Size(width: width, height: height)
        point = Point(x: x, y: y)
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }

}
