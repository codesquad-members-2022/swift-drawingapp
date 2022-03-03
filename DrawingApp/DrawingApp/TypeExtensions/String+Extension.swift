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
}
