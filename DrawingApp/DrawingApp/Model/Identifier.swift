//
//  Identifier.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/02.
//

import Foundation

struct Identifier {
    private var firstToken: String
    private var secondToken: String
    private var thirdToken: String
    private var delimiter: Character
    
    init(firstToken: String, secondToken: String, thirdToken: String, delimiter: Character) {
        self.firstToken = firstToken
        self.secondToken = secondToken
        self.thirdToken = thirdToken
        self.delimiter = delimiter
    }
    
    static func generateToken() -> String {
        let characters = Array(Bound.alphaNumeric)
        
        var token = ""
        (0..<Bound.tokenLength).forEach { _ in
            let randomCharacter = characters[Int.random(in: (0..<characters.count))]
            token.append(randomCharacter)
        }
        return token
    }
}

extension Identifier: CustomStringConvertible {
    var description: String {
        return "\(self.firstToken)\(self.delimiter)\(self.secondToken)\(self.delimiter)\(self.thirdToken)"
    }
}

extension Identifier {
    enum Bound {
        static let alphaNumeric = "abcdefghijklmnopqrstuvxyz0123456789"
        static let tokenLength = 3
    }
}
