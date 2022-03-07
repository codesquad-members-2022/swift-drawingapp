//
//  FactoryRectangleProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

typealias FactoryProperties = FactoryRectangleProperty.ViewProperties

class FactoryRectangleProperty: RectanglePropertyCreator {
    
    // MARK: - Make Model Of View.
    func makeRandomView(as name: String, property: FactoryProperties) -> RectangleProperty? {
        
        let randomLocationProperties = getRandomPoint(from: property)
        let randomColor = getRandomColor()
        let randomID = getRandomId()
        let randomAlpha = getRandomAlpha()
        
        return RectangleProperty(
            as: name,
            using: randomID,
            from: randomLocationProperties,
            color: randomColor,
            alpha: randomAlpha
        )
    }
    
    // MARK: - Private generator
    
    private func getRandomPoint(from properties: FactoryProperties) -> ViewProperties {
        let randomPoint = generateRandomPoint(
            maxPointX: properties.maxX - Double(150),
            maxPointY: (properties.maxY - Double(130 * 2))
        )
        
        return ViewProperties(maxX: randomPoint.x, maxY: randomPoint.y, width: 150, height: 120)
    }
    
    private func getRandomColor() -> RectRGBColor {
        generateRandomRGBColor(maxR: 255, maxG: 255, maxB: 255)!
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
    
    struct ViewProperties {
        var maxX: Double
        var maxY: Double
        var width: Double
        var height: Double
    }
}

