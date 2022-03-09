//
//  Identifier.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/02.
//

import Foundation

class Identifier {
    
    private var firstToken: String
    private var secondToken: String
    private var thirdToken: String
    
    init(firstToken: String, secondToken: String, thirdToken: String) {
        self.firstToken = firstToken
        self.secondToken = secondToken
        self.thirdToken = thirdToken
    }
    
    convenience init() {
        let firstToken = Identifier.generateRandomToken()
        let secondToken = Identifier.generateRandomToken()
        let thirdToken = Identifier.generateRandomToken()
        
        self.init(firstToken: firstToken, secondToken: secondToken, thirdToken: thirdToken)
    }
    
    static func generateRandomToken() -> String {
        let characters = Array(Bound.alphaNumeric)
        
        var id = ""
        (0..<Bound.tokenLength).forEach { _ in
            let randomCharacter = characters[Int.random(in: (0..<characters.count))]
            id.append(randomCharacter)
        }
        return id
    }
}

extension Identifier: CustomStringConvertible {
    var description: String {
        return "\(self.firstToken)-\(self.secondToken)-\(self.thirdToken)"
    }
}

extension Identifier {
    enum Bound {
        static let alphaNumeric = "abcdefghijklmnopqrstuvwxyz0123456789"
        static let tokenLength = 3
    }
}

extension Identifier: Equatable {
    static func == (lhs: Identifier, rhs: Identifier) -> Bool {
        return lhs.firstToken == rhs.firstToken &&
        lhs.secondToken == rhs.secondToken &&
        lhs.thirdToken == rhs.thirdToken
    }
}

extension Identifier: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(firstToken)
        hasher.combine(secondToken)
        hasher.combine(thirdToken)
    }
}
