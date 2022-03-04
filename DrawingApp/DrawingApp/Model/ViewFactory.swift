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
        let backgroundColor = rectangle.backgroundColor
        let convertedColorValue = ViewFactory.convertColorValueToUIColor(r: backgroundColor.r, g: backgroundColor.g, b: backgroundColor.b)
        let alpha = CGFloat(rectangle.alpha.value)
        
        let newView = UIView(frame: CGRect(x: point.x, y: point.y, width: size.width, height: size.height))
        newView.alpha = alpha
        newView.backgroundColor = convertedColorValue
        
        return newView
    }
    
    private static func convertColorValueToUIColor(r: Double, g: Double, b: Double) -> UIColor {
        
        let convertedR = r/Double(255)
        let convertedG = g/Double(255)
        let convertedB = b/Double(255)
        
        return UIColor(red: convertedR, green: convertedG, blue: convertedB, alpha: 1.0)
    }
}
