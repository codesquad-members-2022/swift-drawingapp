//
//  Rectangle.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/15.
//

import Foundation
import CoreGraphics

typealias RectAlpha = Rectangle.AlphaStep

class Rectangle : BaseRect, RectColorful, RectAlphaful, ObjectDescription {
    enum AlphaStep {
        case one, two, three, four, five, six, seven, eight, nine, ten
    }
    private(set) var color : CGColor
    private(set) var alpha : RectAlpha
    
    init(origin: CGPoint = CGPoint.zero,
         size: CGSize = CGSize.zero,
         color: CGColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1),
         alpha: RectAlpha = .ten,
         sequence: Int = 1) {
        self.color = color
        self.alpha = RectAlpha.ten
        super.init(origin: origin, size: size, sequence: sequence)
    }
    
    func changeColor(with color: CGColor) {
        self.color = color
    }
    
    func changeAlpha(to value: RectAlpha) {
        self.alpha = value
    }
    
    var text: String {
        return "Rectangle-\(self.sequence)"
    }
    
    var imageName: String {
        return "Rectangle.png"
    }
}
