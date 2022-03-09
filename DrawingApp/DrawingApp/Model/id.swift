//
//  id.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/02.
//

import Foundation

struct ID: Equatable, Hashable {
    let description: String
    
    init?(with id: String) {
        if ID.isCorrectFormat(id) {
            self.description = id
        } else {
            return nil
        }

    }
    
    init() {
        self.description = ID.generateRandomID()
    }
    
    private static func generateRandomID() -> String {
        func generateRandomString(length: Int) -> String {
            return String(NSUUID().uuidString.prefix(length))
        }
        
        let randomIDParts = [generateRandomString(length: 3), generateRandomString(length: 3), generateRandomString(length: 3)]
        return randomIDParts.joined(separator: "-")
    }
    
    private static func isCorrectFormat(_ id: String) -> Bool {
        let correctFormat = "^[a-zA-Z0-9]..[-][a-zA-Z0-9]..[-][a-zA-Z0-9].."
        if let _ = id.range(of: correctFormat, options: .regularExpression) {
            return true
        } else {
            return false
        }
    }
}
