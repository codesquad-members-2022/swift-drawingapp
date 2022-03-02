//
//  id.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/02.
//

import Foundation

struct ID {
    let description: String
    
    init?(with id: String) {
        if ID.isCorrectFormat(id) {
            self.description = id
        } else {
            return nil
        }

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
