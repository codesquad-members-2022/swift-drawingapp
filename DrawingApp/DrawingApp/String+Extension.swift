//
//  String+Extension.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

extension String {
    static var randomViewIdGenerator: String {
        let char = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var result = String((0..<3).map{ _ in char.randomElement()!})
        for _ in 0..<2 {
            result += ("-"+String((0..<3).map{ _ in char.randomElement()!}))
        }
        
        return result
    }
}
