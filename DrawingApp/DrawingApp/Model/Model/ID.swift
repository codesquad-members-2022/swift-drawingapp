//
//  ID.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/08.
//

import Foundation

struct ID: CustomStringConvertible {
    var uuid = UUID()
    
    static func random() -> ID {
        return ID()
    }
    
    var description: String {
        let uuidStrings = uuid.uuidString.components(separatedBy: "-")
        let partialID1 = uuidStrings[0].prefix(3)
        let partialID2 = uuidStrings[1].prefix(3)
        let partialID3 = uuidStrings[2].prefix(3)
        return "\(partialID1)-\(partialID2)-\(partialID3)"
    }
}
