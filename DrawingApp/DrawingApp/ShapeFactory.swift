//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

enum ShapeFactory {
    private static var identifierCache = Set<String>()
    
    private static func generateIdentifier(length: Int, delimiter: String) -> String {
        var identifier: String = ""
        
        for i in 1...length {
            if let char = Constants.Letter.alphanumeric.randomElement() {
                identifier += String(char)
            }
            
            if i % 3 == 0 && i != length {
                identifier += delimiter
            }
        }
        
        if self.identifierCache.contains(identifier) {
            return self.generateIdentifier(length: length, delimiter: delimiter)
        }
        
        self.identifierCache.update(with: identifier)
        
        return identifier
    }
    
    private static func generateRandomPoint() -> Point {
        let range = Constants.Point.range
        let x = Double.random(in: range, digits: 2)
        let y = Double.random(in: range, digits: 2)
        
        return Point(x: x, y: y)
    }
    
    private static func generateRandomColor() -> Color {
        let range = Constants.Color.range
        let red = Double.random(in: range).rounded()
        let green = Double.random(in: range).rounded()
        let blue = Double.random(in: range).rounded()
        let alpha = Alpha.randomElement()
        
        return Color(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private static func generateRandomSize() -> Size {
        let range = Constants.Size.range
        let width = Double.random(in: range, digits: 2)
        let height = Double.random(in: range, digits: 2)
        
        return Size(width: width, height: height)
    }
    
    static func makeRectangle(x: Double = 0, y: Double = 0, width: Double = 30, height: Double = 30) -> Rectangle {
        let id = self.generateIdentifier(length: 9, delimiter: "-")
        
        return Rectangle(id: id, x: x, y: y, width: width, height: height)
    }
    
    static func makeRandomRectangle() -> Rectangle {
        let id = self.generateIdentifier(length: 9, delimiter: "-")
        let point = self.generateRandomPoint()
        let size = self.generateRandomSize()
        let color = self.generateRandomColor()
        
        return Rectangle(id: id, point: point, size: size, color: color)
    }
}
