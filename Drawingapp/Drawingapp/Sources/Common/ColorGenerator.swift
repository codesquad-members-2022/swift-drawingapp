//
//  ColorGenerator.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/14.
//

import Foundation

protocol ColorValueGenerator {
    var colorR: UInt8 { get }
    var colorG: UInt8 { get }
    var colorB: UInt8 { get }
}

class RandomColorGenerator: ColorValueGenerator {
    var colorR: UInt8 {
        UInt8.random(in: 0...255)
    }
    
    var colorG: UInt8 {
        UInt8.random(in: 0...255)
    }
    
    var colorB: UInt8 {
        UInt8.random(in: 0...255)
    }
}
