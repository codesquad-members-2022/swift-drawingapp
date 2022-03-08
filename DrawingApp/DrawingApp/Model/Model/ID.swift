//
//  ID.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/08.
//

import Foundation

struct ID: Hashable, CustomStringConvertible {
    var uuid = UUID()
    
    static func random() -> ID {
        return ID()
    }
    
    static func == (lhs: ID, rhs: ID) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(uuid)
    }
    
    var description: String {
        let uuidStrings = uuid.uuidString.components(separatedBy: "-")
        let partialID1 = uuidStrings[0].prefix(3)
        let partialID2 = uuidStrings[1].prefix(3)
        let partialID3 = uuidStrings[2].prefix(3)
        return "\(partialID1)-\(partialID2)-\(partialID3)"
    }
}
