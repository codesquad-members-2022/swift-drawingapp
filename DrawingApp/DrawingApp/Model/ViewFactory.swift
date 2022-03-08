//
//  ViewFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/03.
//

import Foundation
import UIKit

class ViewFactory {
    static func generateRectangleView(of rectangle: Rectangle) -> RectangleView {
        let point = rectangle.point
        let size = rectangle.size
        let frame = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
        let backgroundColor = rectangle.backgroundColor
        let convertedColor = backgroundColor.convertToUIColor()
        let alpha = CGFloat(rectangle.alpha.value)
        
        let newView = RectangleView(frame: frame, backgroundColor: convertedColor, alpha: alpha)
        
        return newView
    }
}

extension BackgroundColor {
    fileprivate func convertToUIColor(with alphaValue: Double = 1.0) -> UIColor {
        let convertedRed = Double(self.r) / 255.0
        let convertedGreen = Double(self.g) / 255.0
        let convertedBlue = Double(self.b) / 255.0
        
        return UIColor(red: convertedRed, green: convertedGreen, blue: convertedBlue, alpha: alphaValue)
    }
}
