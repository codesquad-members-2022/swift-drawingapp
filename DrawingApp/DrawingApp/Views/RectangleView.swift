//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import UIKit

class RectangleView: BasicShapeView {
    
}

extension RectangleView: ViewColorChangable {
    func changeBackgroundColor(by newColor: UIColor) {
        backgroundColor = newColor
    }
}

extension RectangleView: ViewAlphaChangable {
    func changeAlpha(to alphaLevel: CGFloat) {
        alpha = alphaLevel
    }
}

