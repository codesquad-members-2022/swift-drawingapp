//
//  DrawingFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/02.
//

import Foundation

class DrawingViewFactory {
    static func make(model: DrawingModel) -> DrawingView {
        switch model {
        case let model as PhotoModel:
            return makePhotoView(model: model)
        case let model as RectangleModel:
            return makeRectangleView(model: model)
        default:
            return makeDrawingView(model: model)
        }
    }
    
    static func makeDrawingView(model: DrawingModel) -> DrawingView {
        DrawingView(point: model.origin, size: model.size, alpha: model.alpha)
    }
    
    static func makeRectangleView(model: RectangleModel) -> RectangleView {
        RectangleView(point: model.origin, size: model.size, alpha: model.alpha, color: model.color)
    }
    
    static func makePhotoView(model: PhotoModel) -> PhotoView {
        PhotoView(point: model.origin, size: model.size, alpha: model.alpha, imageUrl: model.imageUrl)
    }
}
