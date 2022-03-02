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
    
    public func generateRectangle() -> Rectangle {
        let id = generateRandomID()
        let size = Size(width: 150, height: 120)
        let point = generateRandomPoint()
        let backgroundColor = generateRandomColor()
        let alpha = generateRandomAlpha()
        
        let newRectangle = Rectangle(id: id, size: size, point: point, backgroundColor: backgroundColor, alpha: alpha)
        
        delegate?.printLog(of: newRectangle)
        
        return newRectangle
    }
    
    private func generateRandomID() -> String {
        return "\(getRandomString(length: 3))-\(getRandomString(length: 3))-\(getRandomString(length: 3))"
    }
    
    private func getRandomString(length: Int) -> String {
        return String(NSUUID().uuidString.prefix(length))
    }
    
    private func generateRandomPoint() -> Point {
        let maxXPoint = screenSize.width
        let maxYPoint = screenSize.height
        
        return Point(x: Double.random(in: 0...maxXPoint),
                                y: Double.random(in: 0...maxYPoint))
    }
    
    private func generateRandomColor() -> BackgroundColor {
        let red = (0...255).randomElement() ?? 0
        let green = (0...255).randomElement() ?? 0
        let blue = (0...255).randomElement() ?? 0

        return BackgroundColor(r: red, g: green, b: blue)
    }
    
    private func generateRandomAlpha() -> Alpha {
        return Alpha.allCases.randomElement() ?? Alpha.one
    }
}
