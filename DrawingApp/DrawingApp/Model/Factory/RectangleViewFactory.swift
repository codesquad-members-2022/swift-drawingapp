//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/04.
//

import Foundation
import UIKit

class RectangleViewFactory {
    
    private static func createUIColor(by color: (red: Double, green: Double, blue: Double), with alpha: Alpha) -> UIColor {
        let red = color.red / Color.Range.upper
        let green = color.green / Color.Range.upper
        let blue = color.blue / Color.Range.upper
        let alpha = alpha.value
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func createRectangleView(by rectangle: Rectangle) -> UIView {
        let rectangleView = UIView()
        
        let xCoordinate = rectangle.point.x
        let yCoordinate = rectangle.point.y
        
        let width = rectangle.size.width
        let height = rectangle.size.height
        
        let red = rectangle.backGroundColor.red
        let green = rectangle.backGroundColor.green
        let blue = rectangle.backGroundColor.blue
        let alpha = rectangle.alpha
        
        let color = createUIColor(by: (red, green, blue), with: alpha)
        
        rectangleView.frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        rectangleView.backgroundColor = color
        
        return rectangleView
    }
}
