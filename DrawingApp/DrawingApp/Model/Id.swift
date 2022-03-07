//
//  Id.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/07.
//

import Foundation

class Id: CustomStringConvertible {
    var description: String
    
    init() {
        self.description = Id.makeRandomId()
    }
    
    private static func makeRandomId() -> String {
        return UUID().uuidString.prefix(3) + "-" + UUID().uuidString.prefix(3) + "-" + UUID().uuidString.prefix(3)
    }
}
