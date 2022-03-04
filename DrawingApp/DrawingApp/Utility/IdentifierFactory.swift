//
//  TypeFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/03.
//

import Foundation

enum IdentifierFactory: TypeBuilder {
    typealias T = String
    
    private static var identifierCache = Set<String>()
    
    static func makeType(length: Int, delimiter: String) -> String {
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
            return self.makeType(length: length, delimiter: delimiter)
        }
        
        self.identifierCache.update(with: identifier)
        
        return identifier
    }
    
    static func makeTypeRandomly() -> T {
        return self.makeType(length: 9, delimiter: "-")
    }
}
