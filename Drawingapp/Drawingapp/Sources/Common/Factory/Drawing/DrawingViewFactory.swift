//
//  DrawingFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/02.
//

import Foundation
import UIKit

class DrawingViewFactory {
    static func make(rectangle: Rectangle) -> DrawingView {
        let rectangleView = DrawingView()
        rectangleView.update(color: rectangle.color)
        rectangleView.update(point: rectangle.point)
        rectangleView.update(size: rectangle.size)
        rectangleView.update(alpha: rectangle.alpha)
        return rectangleView
    }
    
    static func make(photoRectangle: PhotoRectangle) -> PhotoView {
        let photoView = PhotoView()
        photoView.update(point: photoRectangle.point)
        photoView.update(size: photoRectangle.size)
        photoView.update(alpha: photoRectangle.alpha)
        photoView.update(imageURL: photoRectangle.imageUrl)
        return photoView
    }
}
