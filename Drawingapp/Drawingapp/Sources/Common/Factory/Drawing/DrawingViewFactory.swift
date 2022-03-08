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
        switch model {
        case let model as PhotoModel:
            return makePhotoModel(model: model)
        default:
            return makeDrawingModel(model: model)
        }
    }
    
    static func makeDrawingModel(model: DrawingModel) -> DrawingView {
        DrawingView(point: model.point, size: model.size, color: model.color, alpha: model.alpha)
    }
    
    static func makePhotoModel(model: PhotoModel) -> PhotoView {
        PhotoView(point: model.point, size: model.size, alpha: model.alpha, imageUrl: model.imageUrl)
    }
}
