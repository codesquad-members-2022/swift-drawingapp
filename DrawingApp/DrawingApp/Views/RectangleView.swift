//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import UIKit

class RectangleView: BasicShapeView {
    
    init(point: Point, size: Size, backgroundColor: Color, alpha: Alpha) {
        super.init(point: point, size: size)
        self.changeBackgroundColor(by: backgroundColor)
        self.changeAlpha(to: alpha)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension RectangleView: ViewColorChangable {
    func changeBackgroundColor(by newColor: Color) {
        backgroundColor = UIColor(red: newColor.red / 255.0,
                                  green: newColor.green / 255.0,
                                  blue: newColor.blue / 255.0,
                                  alpha: 1.0)
    }
}

extension RectangleView: ViewAlphaChangable {
    func changeAlpha(to alphaLevel: Alpha) {
        alpha = alphaLevel.value
    }
}
