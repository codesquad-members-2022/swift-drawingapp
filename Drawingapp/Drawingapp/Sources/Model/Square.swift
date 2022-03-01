//
//  Square.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

class Square: CustomStringConvertible {
    let id: String
    private let point: Point
    private let size: Size
    private let color: Color
    private let alpha: Alpha
        
    var minX: Double {
        point.x
    }
    
    var minY: Double {
        point.y
    }
    
    var maxX: Double {
        point.x + size.width
    }
    
    var maxY: Double {
        point.y + size.height
    }
    
    var x: Double {
        point.x
    }
    
    var y: Double {
        point.y
    }
    
    var width: Double {
        size.width
    }
    
    var height: Double {
        size.height
    }
    
    var hexColor: String {
        color.hexColor
    }
    
    var uiColor: UIColor {
        UIColor(red: CGFloat(color.r) / 255, green: CGFloat(color.g) / 255, blue: CGFloat(color.b / 255), alpha: alpha.value)
    }
    
    var description: String {
        "id: ( \(id) ), \(point), \(size), \(color), alpha: \(alpha)"
    }
    
    init(id: String, point: Point = Point(x: 100, y: 100), size: Size = Size(width: 150, height: 120), color: Color = .black, alpha: Alpha = Alpha.ten) {
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
    
    func isSelected(by touchPoint: Point) -> Bool {
        if touchPoint.x >= minX, touchPoint.y >= minY,
           touchPoint.x <= maxX, touchPoint.y <= maxY {
            return true
        }
        return false
    }
}
