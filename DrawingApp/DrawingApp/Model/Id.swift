//
//  Id.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Id {
    private let firstSection : String
    private let secondSection : String
    private let thirdSection : String
    init() {
        let string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString : String {
            (0..<3).map{_ in String(string.randomElement() ?? Character(""))}.joined()
        }
        self.firstSection = randomString
        self.secondSection = randomString
        self.thirdSection = randomString
    }
}

extension Id : CustomStringConvertible, Hashable {
    static func == (lhs: Id, rhs: Id) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        let value = self.firstSection + self.secondSection + self.thirdSection
        hasher.combine(value)
    }
    
    var description: String {
        return "\(firstSection)-\(secondSection)-\(thirdSection)"
    }
}
