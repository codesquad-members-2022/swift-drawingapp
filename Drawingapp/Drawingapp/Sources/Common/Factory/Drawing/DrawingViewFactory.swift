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
            return PhotoView(point: model.origin, size: model.size, alpha: model.alpha, imageUrl: model.imageUrl)
        case let model as RectangleModel:
            return RectangleView(point: model.origin, size: model.size, alpha: model.alpha, color: model.color)
        case let model as LabelModel:
            return LabelView(point: model.origin, size: model.size, alpha: model.alpha, text: model.text, font: model.font, fontColor: model.fontColor)
        default:
            return DrawingView(point: model.origin, size: model.size, alpha: model.alpha)
        }
    }
}
