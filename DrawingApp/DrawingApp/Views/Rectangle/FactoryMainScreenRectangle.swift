//
//  FactoryMainScreenRectangle.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/17.
//

import Foundation

final class FactoryMainScreenRectangle {
    func makeRectangle(from model: RectangleProperty, at index: Int) -> Rectangle? {
        switch model {
        case let model as ImageRectangleProperty:
            return ImageRectangle(model: model, index: index)
        case let model as ColoredRectangleProperty:
            return ColoredRectangle(model: model, index: index)
        default:
            LoggerUtil.debugLog(message: "Initialize rectangle failed. \(model.name)")
            return nil
        }
    }
}
