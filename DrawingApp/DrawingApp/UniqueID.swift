//
//  UniqueID.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/03.
//

import Foundation


struct UniqueID {
    static func generate(split digit: Int, stringCount: Int, separatedBy separator: String = "-") -> String {
        return (0..<digit).map{ _ in randomStrings(count: stringCount) }.joined(separator: separator)
    }
    
    static private func randomStrings(count: Int) -> String {
        return (0..<count).map{ _ in randomUnicode() }.joined()
    }
    
    static private func randomUnicode() -> String {
        let numberOrString = Int.random(in: 0...1)
        if numberOrString == 0 {
            let randomNumber = Int.random(in: 48...57)
            let number = String(UnicodeScalar(randomNumber)!)
            return number
        }
        let randomAlphabet = Int.random(in: 97...122)
        let alphabet = String(UnicodeScalar(randomAlphabet)!)
        return alphabet
    }
}
