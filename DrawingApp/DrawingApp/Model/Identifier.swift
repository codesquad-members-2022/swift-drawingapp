//
//  Identifier.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/07.
//

import Foundation

class Identifier {
    private(set) var id: String
    
    init() {
        self.id = Identifier.makeRandomId()
    }
    
    private static func makeRandomId() -> String {
        return UUID().uuidString.prefix(3) + "-" + UUID().uuidString.prefix(3) + "-" + UUID().uuidString.prefix(3)
    }
}
