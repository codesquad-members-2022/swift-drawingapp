//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class RectangleFactory {
    private let screenSize: (width: Double, height: Double)
    var delegate: RectangleDelegate?
    
    init(screenSize: (width: Double, height: Double)) {
        self.screenSize = screenSize
    }
    
    public func generateRandomRectangle() -> Rectangle? {
        let size = Size(width: 150, height: 120)
        let point = generateRandomPoint()
        let backgroundColor = generateRandomColor()
        let alpha = generateRandomAlpha()
        guard let id = generateRandomID() else { return nil }
        
        let newRectangle = Rectangle(id: id, size: size, point: point, backgroundColor: backgroundColor, alpha: alpha)
        
        delegate?.printLog(of: newRectangle)
        
        return newRectangle
    }
    
    private func generateRandomPoint() -> Point {
        let maxXPoint = screenSize.width
        let maxYPoint = screenSize.height
        
        return Point(x: Double.random(in: 0...maxXPoint),
                                y: Double.random(in: 0...maxYPoint))
    }
    
    private func generateRandomColor() -> BackgroundColor {
        let minimumColorValue = 0
        let maximumColorValue = 255
        
        let red = (minimumColorValue...maximumColorValue).randomElement() ?? minimumColorValue
        let green = (minimumColorValue...maximumColorValue).randomElement() ?? minimumColorValue
        let blue = (minimumColorValue...maximumColorValue).randomElement() ?? minimumColorValue

        return BackgroundColor(r: red, g: green, b: blue,
                               min: minimumColorValue, max: maximumColorValue)
    }
    
    private func generateRandomAlpha() -> Alpha {
        let minimumOpacityLevel = 1
        let maximumOpacityLevel = 10
        
        return Alpha(opacityLevel: (minimumOpacityLevel...maximumOpacityLevel).randomElement() ?? minimumOpacityLevel,
                     min: minimumOpacityLevel, max: maximumOpacityLevel)
    }
    
    private func generateRandomID() -> ID? {
        func generateRandomString(length: Int) -> String {
            return String(NSUUID().uuidString.prefix(length))
        }
        
        let randomIDParts = [generateRandomString(length: 3), generateRandomString(length: 3), generateRandomString(length: 3)]
        return ID.init(with: randomIDParts.joined(separator: "-")) ?? nil
    }
    
}
