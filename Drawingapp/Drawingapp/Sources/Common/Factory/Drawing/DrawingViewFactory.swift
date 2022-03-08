//
//  DrawingFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/02.
//

import Foundation
import UIKit

class DrawingViewFactory {
    static func make(model: DrawingModel) -> DrawingView {
        let drawingView = DrawingView()
        drawingView.update(color: model.color)
        drawingView.update(point: model.point)
        drawingView.update(size: model.size)
        drawingView.update(alpha: model.alpha)
        return drawingView
    }
    
    static func make(photoModel: PhotoModel) -> PhotoView {
        let photoView = PhotoView()
        photoView.update(point: photoModel.point)
        photoView.update(size: photoModel.size)
        photoView.update(alpha: photoModel.alpha)
        photoView.update(imageURL: photoModel.imageUrl)        
        return photoView
    }
}
