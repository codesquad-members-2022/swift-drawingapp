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
            if let char = String.alphanumeric.randomElement() {
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
    
    static func makeRectangle(x: Double = 0, y: Double = 0, width: Double = 30, height: Double = 30) -> Rectangle {
        let id = self.generateIdentifier(length: 9, delimiter: "-")
        let alpha = Alpha.randomElement()
        
        return Rectangle(id: id, x: x, y: y, width: width, height: height, alpha: alpha)
    }
    
    static func makeRandomRectangle() -> Rectangle {
        let id = self.generateIdentifier(length: 9, delimiter: "-")
        let point = PointFactory.makeType()
        let size = SizeFactory.makeType()
        let color = ColorFactory.makeType()
        let alpha = Alpha.randomElement()
        
        return Rectangle(id: id, origin: point, size: size, color: color, alpha: alpha)
    }
}

protocol TypeFactory {
    associatedtype T
    static func makeType() -> T
}

enum ColorFactory: TypeFactory {
    typealias T = Color
    
    static func makeType() -> Color {
        let range = Color.range
        let red = Double.random(in: range).rounded()
        let green = Double.random(in: range).rounded()
        let blue = Double.random(in: range).rounded()
        
        return Color(red: red, green: green, blue: blue)
    }
}

enum SizeFactory: TypeFactory {
    typealias T = Size
    
    static func makeType() -> Size {
        let range = Size.range
        let width = Double.random(in: range, digits: 2)
        let height = Double.random(in: range, digits: 2)
        
        return Size(width: width, height: height)
    }
}

enum PointFactory: TypeFactory {
    typealias T = Point
    
    static func makeType() -> Point {
        let range = Point.range
        let x = Double.random(in: range, digits: 2)
        let y = Double.random(in: range, digits: 2)
        
        return Point(x: x, y: y)
    }
}
