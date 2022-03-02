//
//  RandomRectangleMaker.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import Foundation

class RandomRectangleMaker{
    private let rectangleFactory = RectangleFactory()
    private let rectangleIDFactory = RectangleIDFactory()
    
    func makeRectangle(viewWidth: Double, viewHeight: Double) -> Rectangle{
        let id = rectangleIDFactory.makeID()
        let size = rectangleFactory.makeSize()
        let point = rectangleFactory.makePoint(viewWidth: viewWidth, viewHeight: viewHeight)
        let color = rectangleFactory.makeColor()
        let alpha = rectangleFactory.makeAlpha()
        
        let rectangle = Rectangle(id: id, size: size, point: point, color: color, alpha: alpha)
        
        return rectangle
    }
}
