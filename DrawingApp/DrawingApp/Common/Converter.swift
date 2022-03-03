//
//  Converter.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/03.
//

import Foundation
import UIKit

enum Converter {
    static func toUIColor(_ color: Color) -> UIColor {
        return UIColor(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: CGFloat(color.alpha))
    }
    
    static func toCGPoint(_ point: Point) -> CGPoint {
        return CGPoint(x: point.x, y: point.y)
    }
    
    static func toCGFloat(_ alpha: Alpha) -> CGFloat {
        return CGFloat(alpha.value)
    }
    
    static func toCGSize(_ size: Size) -> CGSize {
        return CGSize(width: size.width, height: size.height)
    }
    
    static func toCGRect(origin: Point, size: Size) -> CGRect {
        return CGRect(origin: toCGPoint(origin), size: toCGSize(size))
    }
}
