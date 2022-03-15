//
//  BasicShapeView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/15.
//

import Foundation
import UIKit

class BasicShapeView: UIView {
    
    private var isHighlighted: Bool = false
    
    //MARK: Functions
    
    private func highlightCorner() {
        layer.borderColor = UIColor.systemCyan.cgColor
        layer.borderWidth = 5
        isHighlighted = true
    }
    
    func clearCorner() {
        layer.borderWidth = 0
        layer.borderColor = .none
        isHighlighted = false
    }
    
    func toggleCorner() {
        isHighlighted ? clearCorner() : highlightCorner()
    }
}

protocol ViewColorChangable {
    func changeBackgroundColor(by newColor: UIColor)
}

protocol ViewAlphaChangable {
    func changeAlpha(to alphaLevel: CGFloat)
}
