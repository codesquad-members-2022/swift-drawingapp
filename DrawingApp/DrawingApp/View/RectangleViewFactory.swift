//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/03/10.
//

import Foundation
import UIKit

struct RectangleViewFactory {

    static func makeView(of shape : Shape) -> RectangleView? {
        let size = shape.size
        let position = shape.position
        let alpha = shape.alpha
        let shapeFrame = CGRect(x: position.x , y: position.y, width: size.width, height: size.height)
        switch shape {
        case let shape as Rectangle:
            let color = shape.backgroundColor
            return RectangleView(frame: shapeFrame, color: color, alpha: alpha)
        case let shape as PhotoRectangle:
            let imageData = shape.backgroundImage
            return PhotoRectangleView(from: shapeFrame, imageData: imageData, alpha: alpha)
        default:
            return nil
        }
    }
}
