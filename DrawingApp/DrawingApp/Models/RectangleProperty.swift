//
//  RectangleProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

/// Rectangle 클래스가 구현하는 View 객체의 Model을 표현합니다.
final class RectangleProperty: RectanglePropertyCreator {
    
    private let name: String
    private let id: String
    
    private(set) var size: RectSize
    private(set) var point: RectOrigin
    
    private(set) var rgbValue: RectRGBColor
    private(set) var alpha: Double
    
    private(set) var backgroundImageData: Data?
    
    init(as name: String, using id: String, from properties: RectangleRect, color rgbValue: RectRGBColor, alpha: Double, backgroundImageData: Data?) {
        self.name = name
        self.id = id
        self.point = RectOrigin(x: properties.maxX, y: properties.maxY)
        self.size = RectSize(width: properties.width, height: properties.height)
        self.rgbValue = rgbValue
        self.alpha = alpha
        self.backgroundImageData = backgroundImageData
    }
    
    // MARK: - Setter/Getter in model
    
    @discardableResult
    func resetRGBColor() -> RectRGBColor? {
        self.rgbValue = generateRandomRGBColor()
        return rgbValue
    }
    
    @discardableResult
    func setAlpha(_ alpha: Double) -> Bool {
        guard alpha >= 0 else { return false }
        self.alpha = alpha
        return true
    }
    
    @discardableResult
    func setSize(_ size: RectSize) -> Bool {
        guard size.width >= 0 || size.height >= 0 else { return false }
        self.size = size
        return true
    }
    
    @discardableResult
    func setPoint(_ point: RectOrigin) -> Bool {
        guard point.x >= 0 || point.y >= 0 else { return false }
        self.point = point
        return true
    }
}

// MARK: - CustomStringConvertible for RectangleProperty
extension RectangleProperty: CustomStringConvertible {
    var description: String {
        "\(name) \(id), \(point), \(size), \(rgbValue), Alpha:\(alpha)"
    }
}
