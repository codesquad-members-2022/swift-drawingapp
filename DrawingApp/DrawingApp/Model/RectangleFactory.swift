//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class RectangleFactory {
    
    public static func makeRandomRectangle(in frame: (width: Double, height: Double)) -> Rectangle {
        let size = Size(width: 150, height: 120)
        let point = PointFactory.makeRandomPoint(in: frame)
        let backgroundColor = BackgroundColorFactory.makeRandomBackgroundColor() 
        let alpha = AlphaFactory.makeRandomAlpha()
        let id = ID()
        
        let newRectangle = Rectangle(id: id, size: size, point: point, backgroundColor: backgroundColor, alpha: alpha)
        return newRectangle
    }
    
}
