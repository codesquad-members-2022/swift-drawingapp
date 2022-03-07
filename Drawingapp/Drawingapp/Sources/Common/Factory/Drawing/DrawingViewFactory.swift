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
    
    static func makePhoto(rectangle: PhotoRectangle) -> PhotoView {
        let photoView = PhotoView()
        photoView.update(point: rectangle.point)
        photoView.update(size: rectangle.size)
        photoView.update(alpha: rectangle.alpha)
        if let url = rectangle.imageUrl {
            photoView.update(imageURL: url)
        }
        
        if let itemProvider = rectangle.itemProvider {
            photoView.update(itemProvider: itemProvider)
        }
        return photoView
    }
}
