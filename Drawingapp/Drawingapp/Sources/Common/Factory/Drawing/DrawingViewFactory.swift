//
//  DrawingFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/02.
//

import Foundation
import UIKit

class DrawingViewFactory {
    func make(type: ViewType) -> SquareView {
        switch type {
        case .square(let square):
            let squareView = SquareView()
            squareView.update(in: square)
            return squareView
        }
    }
}

extension DrawingViewFactory {
    enum ViewType {
        case square(model: Square)
    }
}
