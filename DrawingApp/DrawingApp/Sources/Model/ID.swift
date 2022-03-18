//
//  ID.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/07.
//

import Foundation

class ID {
    static func createId() -> String {
        let id = "abcdefghijklmnopqrstuvwxyz0123456789"
        let length = 9
        var count = 0
        var newId = ""

        for i in 0..<length {
            newId += String(id.shuffled()[i])
            count += 1
            if count % 3 == 0 {
                newId += "-"
            }
        }
        newId.removeLast()
        
        return newId
    }
}

extension ID: CustomStringConvertible {
    var description: String {
        return ID.createId()
    }
}

extension ID: Equatable {
    static func == (lhs: ID, rhs: ID) -> Bool {
        return lhs.description == rhs.description
    }
}
