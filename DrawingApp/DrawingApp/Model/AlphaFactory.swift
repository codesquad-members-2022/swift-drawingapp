//
//  AlphaFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/06.
//

import Foundation

class AlphaFactory {
    public static func makeRandomAlpha() -> Alpha {
        let randomOpacityLevel = Alpha.OpacityLevel.allCases.randomElement() ?? Alpha.OpacityLevel.ten
        return Alpha(opacityLevel: randomOpacityLevel)
    }
}
