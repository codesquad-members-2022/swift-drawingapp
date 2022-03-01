//
//  Square.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

class Square: CustomStringConvertible {
    
    struct InspectorData {
        let alpha: Alpha
        let hexColor: String
    }
    
    let id: String
    private let point: Point
    private let size: Size
    private var color: Color
    private var alpha: Alpha
    
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
    
    func changeRandomColor() {
        let colorValues = (0..<3).map{ _ in Int.random(in: 0...255) }
        color = Color(r: colorValues[0], g: colorValues[1], b: colorValues[2])
    }
    
    func update(alphaValue: Float) {
        self.alpha = Alpha(rawValue: Int(alphaValue)) ?? .ten
    }
}

extension Square {
    
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
    
    var uiColor: UIColor {
        UIColor(red: CGFloat(color.r) / 255, green: CGFloat(color.g) / 255, blue: CGFloat(color.b / 255), alpha: alpha.value)
    }
    
    var rect: CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }
    
    var inspectorData: InspectorData {
        InspectorData(alpha: self.alpha, hexColor: color.hexColor)
    }
}
