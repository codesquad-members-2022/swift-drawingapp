//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

protocol BackgroundColorChangable {
    var backgroundColor: BackgroundColor {get}
    
    func changeBackgroundColor(to newColor: BackgroundColor)
}

class Rectangle: AnyRectangularable, BackgroundColorChangable {
    private(set) var backgroundColor: BackgroundColor
    
    init(size: Size, point: Point, backgroundColor: BackgroundColor, alpha: Alpha) {
        self.backgroundColor = backgroundColor
        super.init(size: size, point: point, alpha: alpha)
    }
    
    func changeBackgroundColor(to newColor: BackgroundColor) {
        self.backgroundColor = newColor
    }

}
