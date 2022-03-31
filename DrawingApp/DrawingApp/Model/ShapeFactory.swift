//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class ShapeFactory {

    private let randomRectangleWidth = 150.0
    private let randomRectangleHeight = 120.0
    
    func createRectangle(point: Point, size: Size, color: Color, alpha: Alpha) -> Rectangle {
        let id = generateId()
        return Rectangle(id: id, point: point, size: size, color: color, alpha: alpha)
    }
    
    func createRandomRectangle() -> Rectangle {
        return Rectangle(id: generateId(),
                         point: generateRandomPoint(),
                         size: Size(width: randomRectangleWidth, height: randomRectangleHeight),
                         color: generateRandomColor(),
                         alpha: generateRandomAlpha())
    }
    
    private func generateId() -> String {
        return UUID().uuidString.prefix(3) + "-" + UUID().uuidString.prefix(3) + "-" + UUID().uuidString.prefix(3)
    }
    
    private func generateRandomPoint() -> Point {
        let x = Int.random(in: 1...Int(ViewController.screenWidth))
        let y = Int.random(in: 1...Int(ViewController.screenHeight))
        return Point(x: Double(x), y: Double(y))
    }
    
    private func generateRandomColor() -> Color {
        return Color.generateRandomColor()
    }
    
    private func generateRandomAlpha() -> Alpha {
        return Alpha.generateRandomAlpha()
    }
}
