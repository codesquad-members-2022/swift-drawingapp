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
    let point: Point
    let size: Size
    let backgroundColor: Color
    let alpha: Alpha
        
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
    
    var description: String {
        "id: ( \(id) ), \(point), \(size), \(backgroundColor), alpha: \(alpha)"
    }
    
    init(id: String, point: Point = Point(x: 100, y: 100), size: Size = Size(width: 150, height: 120), backgroundColor: Color = .black, alpha: Alpha = Alpha.ten) {
        self.id = id
        self.point = point
        self.size = size
        self.backgroundColor = backgroundColor
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
