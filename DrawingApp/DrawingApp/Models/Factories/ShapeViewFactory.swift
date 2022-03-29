//
//  ShapeViewFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import UIKit

class ShapeViewFactory {
    
    private static func createBasicShapeView(shape: BasicShape) -> BasicShapeView {
        return BasicShapeView(point: shape.point, size: shape.size)
    }
    
    private static func createRectangleView(rectangle: Rectangle) -> RectangleView {
        return RectangleView(point: rectangle.point,
                             size: rectangle.size,
                             backgroundColor: rectangle.backgroundColor,
                             alpha: rectangle.alpha)
    }
    
    private static func createPictureView(picture: Picture) -> PictureView {
        return PictureView(point: picture.point,
                           size: picture.size,
                           alpha: picture.alpha,
                           imageBinaryData: picture.imageBinaryData)
    }
    
    static func createShapeView(by shape: BasicShape) -> BasicShapeView {
        switch shape {
        case let shape as Rectangle:
            return createRectangleView(rectangle: shape)
        case let shape as Picture:
            return createPictureView(picture: shape)
        default:
            return createBasicShapeView(shape: shape)
        }
    }
}
