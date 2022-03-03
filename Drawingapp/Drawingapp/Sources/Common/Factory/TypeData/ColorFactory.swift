//
//  ColorFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/03.
//

import Foundation

class ColorFactory {
    static func make<T: RandomColorValueGenerator>(using generator: T) -> Color {
        let colorValues = generator.next()
        return Color(r: colorValues[0], g: colorValues[1], b: colorValues[2])
    }
    
    static func make() -> Color {
        let ramdomGenerator = RandomColorGenerator()
        return self.make(using: ramdomGenerator)
    }
}

protocol RandomColorValueGenerator {
    func next() -> [Int]
}

fileprivate class RandomColorGenerator: RandomColorValueGenerator {
    func next() -> [Int] {
        (0..<3).map{ _ in Int.random(in: 0...255) }
    }
}
