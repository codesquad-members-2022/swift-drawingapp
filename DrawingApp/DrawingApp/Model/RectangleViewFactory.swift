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
        guard let color = rectangle.backGroundColor else {return nil}
        let alpha = rectangle.alpha
        let rectangleFrame = CGRect(x: position.x , y: position.y, width: size.width, height: size.height)
        return RectangleView(from: rectangleFrame, color: color, alpha: alpha)
    }
    
    static func makePhotoView(of photoRectangle: PhotoRectangle) -> PhotoRectangleView? {
        let size = photoRectangle.size
        let position = photoRectangle.position
        let image = photoRectangle.backGroundImage
        let alpha = photoRectangle.alpha
        let rectangleFrame = CGRect(x: position.x , y: position.y, width: size.width, height: size.height)
        return PhotoRectangleView(from: rectangleFrame, image: image, alpha: alpha)
    }
}
