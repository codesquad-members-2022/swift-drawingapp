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
    private var color: Color
    private var alpha: Alpha
    
    var description: String {
        "id: ( \(id) ), \(point), \(size), \(color), alpha: \(alpha)"
    }
    
    init(id: String, point: Point, size: Size, color: Color, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
    
    func isSelected(by touchPoint: Point) -> Bool {
        if touchPoint.x >= point.x, touchPoint.y >= point.y,
           touchPoint.x <= point.x + size.width, touchPoint.y <= point.y + size.height {
            return true
        }
        return false
    }
    
    func update(color: Color) {
        self.color = color
//        let colorValues = (0..<3).map{ _ in Int.random(in: 0...255) }
//        color = Color(r: colorValues[0], g: colorValues[1], b: colorValues[2])
    }
    
    func update(alpha: Alpha?) {
        guard let alpha = alpha else {
            return
        }
        self.alpha = alpha
    }
}

extension Square {
    struct InspectorData {
        let alpha: Alpha
        let hexColor: String
    }
    
    var inspectorData: InspectorData {
        InspectorData(alpha: self.alpha, hexColor: color.hexColor)
    }
}

extension Square {
    
    var uiColor: UIColor {
        UIColor(red: CGFloat(color.r) / 255, green: CGFloat(color.g) / 255, blue: CGFloat(color.b / 255), alpha: alpha.value)
    }
    
    var rect: CGRect {
        CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
    }
}
