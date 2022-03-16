//
//  FactoryRectangleProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

typealias ScreenSceneRect = FactoryRectangleProperty.ScreenRect
typealias RectangleDefaultSize = FactoryRectangleProperty.DefaultSize

/// Rectangle 객체를 생성하는 인터페이스를 제공하는 클래스입니다.
final class FactoryRectangleProperty: RectanglePropertyCreator {
    
    // MARK: - Make Model Of View.
    func makeRandomRectangleModel(as name: String, in rect: ScreenSceneRect, imageData data: Data? = nil) -> RectangleProperty? {
        
        let randomLocationProperties = getRandomPoint(from: rect)
        let randomColor = getRandomColor()
        let randomID = getRandomId()
        let randomAlpha = getRandomAlpha()
        
        return RectangleProperty(
            as: name,
            using: randomID,
            from: randomLocationProperties,
            color: randomColor,
            alpha: randomAlpha,
            backgroundImageData: data
        )
    }
    
    // MARK: - Private generator
    
    private func getRandomPoint(from properties: ScreenSceneRect) -> ScreenRect {
        let maxSize = (width: RectangleDefaultSize.width.rawValue, height: RectangleDefaultSize.height.rawValue)
        let randomPoint = generateRandomPoint(
            maxPointX: properties.maxX - maxSize.width,
            maxPointY: properties.maxY - maxSize.height
        )
        
        return ScreenRect(maxX: randomPoint.x, maxY: randomPoint.y, width: maxSize.width, height: maxSize.height)
    }
    
    private func getRandomColor() -> RectRGBColor {
        generateRandomRGBColor()
    }
    
    private func getRandomId() -> String {
        var threeAlphabets: String {
            (0..<3).reduce("") { s, _ in (s + String.allAlphabet.randomElement()!) }
        }
        
        return "\(threeAlphabets)-\(threeAlphabets)-\(threeAlphabets)"
    }
    
    private func getRandomAlpha() -> Double {
        Double(getIntRandom(from: 1, to: 10))
    }
    
    struct ScreenRect {
        var maxX: Double
        var maxY: Double
        var width: Double
        var height: Double
    }
    
    enum DefaultSize: Double {
        case width = 150
        case height = 120
    }
}

