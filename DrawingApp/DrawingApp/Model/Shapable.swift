//
//  Shapable.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation
import UIKit

protocol Shapable: CustomStringConvertible {
    var id: Identifier { get }
    var size: Size { get }
    var point: Point { get }
    var backgroundColor: Color { get }
    var alpha: Alpha { get }
}

extension Shapable {
    
    var description: String {
        return "(\(self.id)), \(self.point), \(self.size), \(self.backgroundColor)"
    }
    
    func getColorHexaValue() -> String {
        let red = Int(backgroundColor.red)
        let green = Int(backgroundColor.green)
        let blue = Int(backgroundColor.blue)
        
        return "\(String(format: "#%02X%02X%02X", red, green, blue))"
    }
    
    func getUIColor() -> UIColor {
        let red = backgroundColor.red / Color.Range.upper
        let green = backgroundColor.green / Color.Range.upper
        let blue = backgroundColor.blue / Color.Range.upper
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func getAlpha() -> CGFloat {
        return CGFloat(alpha.value)
    }
    
    func getFrame() -> CGRect {
        let xCoordinate = point.x
        let yCoordinate = point.y
        
        let width = size.width
        let height = size.height
        
        let frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        return frame
    }
}
