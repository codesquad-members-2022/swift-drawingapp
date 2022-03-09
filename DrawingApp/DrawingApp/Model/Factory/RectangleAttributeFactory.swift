//
//  RectangleAttributeFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/04.
//

import Foundation
import UIKit

class RectangleAttributeFactory {
    
    static func createUIColor(by rectangle: Rectangle) -> UIColor {
        let red = rectangle.backGroundColor.red / Color.Range.upper
        let green = rectangle.backGroundColor.green / Color.Range.upper
        let blue = rectangle.backGroundColor.blue / Color.Range.upper
        let alpha = rectangle.alpha.value
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func createRectangleFrame(by rectangle: Rectangle) -> CGRect {
        let xCoordinate = rectangle.point.x
        let yCoordinate = rectangle.point.y
        
        let width = rectangle.size.width
        let height = rectangle.size.height
        
        let frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        return frame
    }
}
