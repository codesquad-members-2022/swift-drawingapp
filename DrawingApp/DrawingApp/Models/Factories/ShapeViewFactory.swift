//
//  ShapeViewFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import UIKit

class ShapeViewFactory {
    
    private static func createBasicShapeView(shape: BasicShape)-> BasicShapeView {
        return BasicShapeView(point: shape.point, size: shape.size)
    }
    
    private static func createRectangleView(rectangle: Rectangle)-> RectangleView {
        return RectangleView(point: rectangle.point,
                             size: rectangle.size,
                             backgroundColor: rectangle.backgroundColor,
                             alpha: rectangle.alpha)
    }
    
    static func createShapeView(by shape: BasicShape) -> BasicShapeView {
        switch shape {
        case let shape as Rectangle:
            return createRectangleView(rectangle: shape)
        default:
            return createBasicShapeView(shape: shape)
        }
    }
}
