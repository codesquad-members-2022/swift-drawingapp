//
//  String+Extension.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

extension String {

    static var uppercaseAlphabet = (65...90).map {String(UnicodeScalar($0))}
    static var lowercaseAlphabet = (97...122).map {String(UnicodeScalar($0))}
    static var allAlphabet = (uppercaseAlphabet + lowercaseAlphabet)

    static var randomViewIdGenerator: String {
//        let char = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
//        var result = String((0..<3).map{ _ in char.randomElement()!})
//        for _ in 0..<2 {
//            result += ("-"+String((0..<3).map{ _ in char.randomElement()!}))
//        }
//        return result
        
        var randomThreeAlphabet: String {
            (0..<3).reduce("") { result, _ in return (result + allAlphabet.randomElement()!) }
        }
        var result = randomThreeAlphabet
        
        for _ in 0..<2 {
            result += "-\(randomThreeAlphabet)"
        }
        return result
    }
}
