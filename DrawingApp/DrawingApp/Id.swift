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

extension Id : CustomStringConvertible {
    var description: String {
        return "\(firstSection)-\(secondSection)-\(thirdSection)"
    }
}
