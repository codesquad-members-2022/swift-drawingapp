//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/02.
//

import Foundation


protocol RectangleCreator {
    
    func createRandomRectangle() -> Rectangle
    func createRectangle(size: Size, position: Point) -> Rectangle
    func createRectangle(x: Double, y: Double, width: Double, height: Double) -> Rectangle
    func createColoredRectangle(size: Size, position: Point, color: Color, alpha: Alpha) -> Rectangle
    
}


class Rectangle: CustomStringConvertible{
    
    private var ID: String
    private var size: Size
    private var position: Point
    private var backgroundColor: Color
    private var alpha: Alpha
    
    var leftTopPoint: Point {
        return position
    }
    var rightBottomPoint: Point {
        return Point(x: Double(position.x + size.width) , y: Double(position.y + size.width))
    }
    
    required init(ID: String, size: Size, position: Point, backgroundColor: Color, alpha: Alpha) {
        self.ID = ID
        self.size = size
        self.position = position
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    var description: String {
        return "\(ID), \(size), \(position), \(backgroundColor), \(alpha)"
    }

}
