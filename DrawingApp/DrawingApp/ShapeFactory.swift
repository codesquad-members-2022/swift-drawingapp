//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

struct ShapeFactory {
    private static let letters = "abcdefghjklmnpqrstuvwxyz12345789"
    private static var identifierCache = [String: Bool]()
    
    static func generateIdentifier() -> String {
        var identifier: String = ""
        
        for i in 1...9 {
            if let char = letters.randomElement() {
                identifier += String(char)
            }
            
            if i % 3 == 0 && i / 3 < 3 {
                identifier += "-"
            }
        }
        
        if let isDuplicate = self.identifierCache[identifier], isDuplicate == true {
            return self.generateIdentifier()
        }
        
        self.identifierCache[identifier] = true
        
        return identifier
    }
    
    static func makeRectangle(x: Double = 0, y: Double = 0, width: Double = 30, height: Double = 30) -> Rectangle {
        let id = self.generateIdentifier()
        return Rectangle(id: id, x: x, y: y, width: width, height: height)
    }
}
