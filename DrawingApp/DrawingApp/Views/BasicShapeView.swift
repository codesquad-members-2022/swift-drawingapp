//
//  BasicShapeView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/15.
//

import UIKit

class BasicShapeView: UIView {
    
    init(point: Point, size: Size) {
        super.init(frame: CGRect(origin: CGPoint(x: point.x, y: point.y),
                                 size: CGSize(width: size.width, height: size.height)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
    func changeBackgroundColor(by newColor: Color)
}

protocol ViewAlphaChangable {
    func changeAlpha(to alphaLevel: Alpha)
}
