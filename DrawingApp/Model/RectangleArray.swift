//
//  RectangleArray.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

class RectangleArray{
    private var rectangles: [Rectangle] = []
    private var lastRectangle: Rectangle?
    private let rectangleFactory = RectangleFactory()
    
    func makeRectangle(viewWidth: Double, viewHeight: Double){
        let id = rectangleFactory.makeId()
        let size = rectangleFactory.makeSize()
        let point = rectangleFactory.makePoint(viewWidth: viewWidth, viewHeight: viewHeight)
        let color = rectangleFactory.makeColor()
        let alpha = rectangleFactory.makeAlpha()
        
        let rectangle = Rectangle(id: id, size: size, point: point, color: color, alpha: alpha)
        appendRectangle(rectangle: rectangle)
    }
    
    func appendRectangle(rectangle: Rectangle){
        lastRectangle = rectangle
        rectangles.append(rectangle)
    }
    
    func nowMadeRectangle() -> Rectangle?{
        return lastRectangle
    }
}
