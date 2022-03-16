//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/03/10.
//

import Foundation
import UIKit

struct ShapeViewFactory {

    static func makeView(of shape : Shape) -> ShapeViewAble? {
        let size = shape.size
        let position = shape.position
        let alpha = shape.alpha
        let shapeFrame = CGRect(x: position.x , y: position.y, width: size.width, height: size.height)
        switch shape {
        case let rectangle as Rectangle:
            let color = rectangle.backgroundColor
            return RectangleView(frame: shapeFrame, color: color, alpha: alpha)
        case let photoRectangle as PhotoRectangle:
            let imageData = photoRectangle.backgroundImage
            return PhotoRectangleView(from: shapeFrame, imageData: imageData, alpha: alpha)
        default:
            return nil
        }
    }
}
