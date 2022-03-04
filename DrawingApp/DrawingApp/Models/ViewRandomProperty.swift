//
//  ViewRandomProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

class ViewRandomProperty: ViewPropertyCreator {
    
    private let name: String
    private let id: String
    
    private var size: RectSize
    private var point: RectPoint
    
    private var rgbValue: RectRGBColor
    private var alpha: Double
    
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
    
    // MARK: - Setter/Getter in model
    
    @discardableResult
    func resetRGBColor() -> RectRGBColor {
        rgbValue = generateRandomRGBColor(maxR: 255, maxG: 255, maxB: 255)
        return rgbValue
    }
    
    func getRGBColor() -> RectRGBColor {
        rgbValue
    }
    
    @discardableResult
    func setAlpha(_ alpha: Double) -> Bool {
        guard alpha >= 0 else { return false }
        self.alpha = alpha
        return true
    }
    
    func getAlpha() -> Double {
        alpha
    }
    
    @discardableResult
    func setSize(_ size: RectSize) -> Bool {
        guard size.width >= 0 || size.height >= 0 else { return false }
        self.size = size
        return true
    }
    
    func getSize() -> RectSize {
        size
    }
    
    @discardableResult
    func setPoint(_ point: RectPoint) -> Bool {
        guard point.x >= 0 || point.y >= 0 else { return false }
        self.point = point
        return true
    }
    
    func getPoint() -> RectPoint {
        point
    }
}

// MARK: - CustomStringConvertible

extension ViewRandomProperty: CustomStringConvertible {
    var description: String {
        "\(name) \(id), \(point), \(size), \(rgbValue), Alpha:\(alpha)"
    }
}
