//
//  DrawingFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/02.
//

import Foundation
import UIKit

class DrawingViewFactory {
    static func make(square: Square) -> SquareView {
        let squareView = SquareView()
        squareView.update(color: square.color)
        squareView.update(point: square.point)
        squareView.update(size: square.size)
        squareView.update(alpha: square.alpha)
        return squareView
    }
}
