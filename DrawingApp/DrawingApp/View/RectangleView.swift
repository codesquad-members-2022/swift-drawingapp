//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import Foundation
import UIKit

class RectangleView: BasicShapeView {
    
    private var isHighlighted: Bool = false
    
    //MARK: Functions
    
    private func highlightCorner() {
        layer.borderColor = UIColor.systemCyan.cgColor
        layer.borderWidth = 5
        isHighlighted = true
    }
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

