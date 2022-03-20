//
//  Drawing.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/18.
//

import Foundation
import CoreGraphics

class Drawing : BaseRect, RectColorful, RectAlphaful, PointAccessable, ObjectDescription {
    private(set) var points : [CGPoint]
    private(set) var alpha : RectAlpha
    private(set) var color : CGColor

    init(origin: CGPoint = CGPoint.zero,
         size: CGSize = CGSize.zero,
         points: [CGPoint],
         color: CGColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1),
         alpha: RectAlpha = .ten,
         sequence: Int = 1) {
        self.alpha = RectAlpha.ten
        self.color = color
        self.points = points
        super.init(origin: origin, size: size, sequence: sequence)
    }

    func changeColor(with color: CGColor) {
        self.color = color
    }

    func changeAlpha(to value: RectAlpha) {
        self.alpha = value
    }
    
    var text: String {
        return "Drawing-\(sequence)"
    }
    
    var imageName: String {
        return "Drawing.png"
    }
}

