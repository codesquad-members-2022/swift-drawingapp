//
//  AlphaFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/06.
//

import Foundation

class AlphaFactory {
    public static func generateRandomAlpha() -> Alpha? {
        let randomOpacityLevel = OpacityLevel.possibleOpacityLevels.randomElement() ?? OpacityLevel.ten
        return Alpha(opacityLevel: randomOpacityLevel)
    }
}
