//
//  CGConverter.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import UIKit

class CGConverter {
    
    static func toUIColor(from color: Color) -> UIColor {
        let red = color.red / Color.Range.upper
        let green = color.green / Color.Range.upper
        let blue = color.blue / Color.Range.upper
        let alpha = Color.Alpha.default
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func toCGPoint(from point: Point) -> CGPoint {
        return CGPoint(x: point.x, y: point.y)
    }
    
    static func toCGRect(from rect: (point: Point, size: Size)) -> CGRect {
        return CGRect(x: rect.point.x, y: rect.point.y, width: rect.size.width, height: rect.size.height)
    }
    
    static func toCGFloat(from alpha: Alpha) -> CGFloat {
        return CGFloat(alpha.value)
    }
}
