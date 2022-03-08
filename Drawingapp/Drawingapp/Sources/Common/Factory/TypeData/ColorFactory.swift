//
//  ColorFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/03.
//

import Foundation

class ColorFactory {
    func make<T: ColorValueGenerator>(using generator: T) -> Color {
        return Color(using: generator)
    }
    
    func makeRandomColor() -> Color {
        let ramdomGenerator = RandomColorGenerator()
        return self.make(using: ramdomGenerator)
    }
}

protocol ColorValueGenerator {
    var colorR: UInt { get }
    var colorG: UInt { get }
    var colorB: UInt { get }
}

class RandomColorGenerator: ColorValueGenerator {
    var colorR: UInt {
        UInt.random(in: 0...255)
    }
    
    var colorG: UInt {
        UInt.random(in: 0...255)
    }
    
    var colorB: UInt {
        UInt.random(in: 0...255)
    }
}
