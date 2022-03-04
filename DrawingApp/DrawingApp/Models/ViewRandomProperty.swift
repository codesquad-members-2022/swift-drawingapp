//
//  ViewRandomProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

struct RectSize {
    var width: Double
    var height: Double
}

struct RectPoint {
    var x: Double
    var y: Double
}

struct RectRGBColor {
    var r: Double
    var g: Double
    var b: Double
}

class ViewRandomProperty: ViewPropertyCreator {
    
    private let name: String
    private let id: String
    
    private var size: RectSize
    private var point: RectPoint
    
    private var rgbValue: RectRGBColor
    private(set) var alpha: Double
    
    init(as name: String, using id: String, at point: RectPoint, size: RectSize, color: RectRGBColor, alpha: Double) {
        self.name = name
        self.id = id
        self.point = point
        self.size = size
        self.rgbValue = color
        self.alpha = alpha
    }
    
    init(as name: String, using id: String, from properties: FactoryProperties, color: RectRGBColor, alpha: Double) {
        self.name = name
        self.id = id
        self.point = RectPoint(x: properties.maxX, y: properties.maxY)
        self.size = RectSize(width: properties.width, height: properties.height)
        self.rgbValue = color
        self.alpha = alpha
    }
    
    @discardableResult
    func resetRGBColor() -> RectRGBColor {
        self.rgbValue = generateRandomRGBColor(maxR: 255, maxG: 255, maxB: 255)
        return rgbValue
    }
    
    func getRGBColor() -> RectRGBColor {
        rgbValue
    }
    
    func setAlpha(_ alpha: Double) {
        self.alpha = alpha
    }
    
    func getAlpha() -> Double {
        alpha
    }
    
    func setSize(_ size: RectSize) {
        self.size = size
    }
    
    func getSize() -> RectSize {
        size
    }
    
    func setPoint(_ point: RectPoint) {
        self.point = point
    }
    
    func getPoint() -> RectPoint {
        point
    }
}

extension ViewRandomProperty: CustomStringConvertible {
    var description: String {
        "\(name) \(id), X:\(point.x),Y:\(point.y), W\(size.width), H\(size.height), R:\(rgbValue.r), G:\(rgbValue.g), B:\(rgbValue.b), Alpha:\(alpha)"
    }
}
