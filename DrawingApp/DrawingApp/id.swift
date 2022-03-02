//
//  id.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/02.
//

import Foundation

struct ID {
    let description: String
    
    init() {
        self.description = ID.generateRandomID()
    }
    
    private static func generateRandomID() -> String {
        return "\(generateRandomPartOfID(length: 3))-\(generateRandomPartOfID(length: 3))-\(generateRandomPartOfID(length: 3))"
    }
    
    private static func generateRandomPartOfID(length: Int) -> String {
        return String(NSUUID().uuidString.prefix(length))
    }
}
