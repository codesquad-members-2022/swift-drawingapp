//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/03/10.
//

import Foundation
import UIKit

struct RectangleViewFactory {

    static func makeView(of rectangle : Rectangle) -> RectangleView? {
        let size = rectangle.size
        let position = rectangle.position
        let color = rectangle.backgroundColor
        let alpha = rectangle.alpha
        let rectangleFrame = CGRect(x: position.x , y: position.y, width: size.width, height: size.height)
        return RectangleView(frame: rectangleFrame, color: color, alpha: alpha)
    }
    
    static func makePhotoView(of photoRectangle: Rectangle) -> PhotoRectangleView? {
        let size = photoRectangle.size
        let position = photoRectangle.position
        guard let imageData = photoRectangle.backgroundImage else {return nil}
        let alpha = photoRectangle.alpha
        let rectangleFrame = CGRect(x: position.x , y: position.y, width: size.width, height: size.height)
        return PhotoRectangleView(from: rectangleFrame, imageData: imageData, alpha: alpha)
    }
}
