//
//  ViewFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/03.
//

import Foundation
import UIKit

class ViewFactory {
    static func generateRectangleView(of rectangle: Rectangle) -> UIView {
        let point = rectangle.point
        let size = rectangle.size
        let frame = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
        let backgroundColor = rectangle.backgroundColor
        let convertedColor = Converter.convertToUIColor(backgroundColor: backgroundColor)
        let alpha = CGFloat(rectangle.alpha.value)
        
        let newView = RectangleView(id: rectangle.id, frame: frame, backgroundColor: convertedColor, alpha: alpha)
        
        return newView
    }
}
