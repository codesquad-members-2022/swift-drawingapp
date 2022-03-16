//
//  ColoredRectangleProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/16.
//

import Foundation

final class ColoredRectangleProperty: RectangleProperty {
    
    private(set) var rgbValue: RectRGBColor
    
    init(as name: String, using id: String, from screenRect: ScreenSceneRect, color rgbValue: RectRGBColor, alpha: Double) {
        self.rgbValue = rgbValue
        super.init(as: name, using: id, from: screenRect, alpha: alpha)
    }
    
    @discardableResult
    func resetRGBColor() -> RectRGBColor? {
        self.rgbValue = generateRandomRGBColor()
        return rgbValue
    }
}

extension ColoredRectangleProperty: CustomStringConvertible {
    var description: String {
        "\(name) \(id), \(point), \(size), \(rgbValue), Alpha:\(alpha)"
    }
}
