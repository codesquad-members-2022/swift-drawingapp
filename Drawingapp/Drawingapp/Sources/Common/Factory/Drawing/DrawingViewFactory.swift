//
//  DrawingFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/02.
//

import Foundation
import UIKit

class DrawingViewFactory {
    static func make(rectangle: Rectangle) -> RectangleView {
        let rectangleView = RectangleView()
        rectangleView.update(color: rectangle.color)
        rectangleView.update(point: rectangle.point)
        rectangleView.update(size: rectangle.size)
        rectangleView.update(alpha: rectangle.alpha)
        return rectangleView
    }
}
