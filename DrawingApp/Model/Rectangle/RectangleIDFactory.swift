//
//  RectangleIDFactory.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import Foundation

class RectangleIDFactory{
    func makeID() -> String{
        let alphabet: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        var name: [String] = []
        
        for num in 0..<11{
            guard let randomString = alphabet.randomElement() else{
                break
            }
            
            if num == 3 || num == 7{
                name.append("-")
            } else{
                name.append(randomString)
            }
        }
        
        return name.joined()
    }
}
