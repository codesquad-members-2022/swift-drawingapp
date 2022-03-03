//
//  SizeFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

final class SizeFactory {
    static func makeRandomSize() -> Size {
        let randomWidth = Double.random(in: 0.0...Size.maxWidth)
        let randomHeight = Double.random(in: 0.0...Size.maxHeight)
        
        return Size(width: randomWidth, height: randomHeight)
    }
}
