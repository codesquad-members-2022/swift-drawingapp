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
    
    private(set) var ID: String
    private(set) var size: Size
    private(set) var position: Point
    private(set) var backgroundColor: Color
    private(set) var alpha: Alpha
    
    var leftTopPoint: Point {
        return position
    }
    var rightBottomPoint: Point {
        return Point(x: Double(position.x + size.width) , y: Double(position.y + size.height))
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
    
    func changedBackGroundColor(to color: Color){
        self.backgroundColor = color
    }
    
    func changedAlpha(to value: Int){
        self.alpha = Alpha(rawValue: value) ?? .opaque
    }

}

extension Rectangle: Hashable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ID)
    }
    
}
