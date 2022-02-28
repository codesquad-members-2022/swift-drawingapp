//
//  Square.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import Foundation

class Square: CustomStringConvertible {
    private var id: String
    
    private var width: Double
    private var height: Double
    
    private var positionX: Double
    private var positionY: Double
    
    private var color: Color
    
    init(width: Double, height: Double, positionX: Double, positionY: Double, color: Color) {
        self.id = UUID().uuidString.prefix(9).reduce("") { partialResult, char in
            "\(partialResult)\(char)"
        }
        self.width = width
        self.height = height
        self.positionX = positionX
        self.positionY = positionY
        self.color = color
    }
    
    var description: String {
        return "(\(id)), X:\(positionX), Y:\(positionY), W\(width), H\(height), R:\(color.red), G:\(color.green), B:\(color.blue), A: \(color.alpha)"
    }
}

