//
//  AlphaFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

final class AlphaFactory {
    
    static func makeRandomAlpha() -> Alpha {
        let randomAlpha = Float.random(in:Alpha.minValue...Alpha.maxValue)
        
        return Alpha(randomAlpha)
    }
    
}
