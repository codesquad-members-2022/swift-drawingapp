//
//  RectanglePropertyCreator.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/01.
//

import Foundation

/// Rectangle, Plane 클래스에서 사용될 프로퍼티 객체들을 만드는 클래스입니다.
///
/// 랜덤 값 추출이 필요하기 때문에 RandomizeValue 서브클래싱을 진행합니다.
class RectanglePropertyCreator: RandomizeValue {
    
    func generateRandomPoint(
        maxPointX: Double,
        maxPointY: Double) -> RectOrigin {
        
        RectOrigin(
            x: getDoubleRandom(from: 0, to: maxPointX),
            y: getDoubleRandom(from: 0, to: maxPointY)
        )
    }
    
    func generateRandomSize(
        maxWidth: Double = RectangleDefaultSize.width.rawValue,
        maxHeight: Double = RectangleDefaultSize.height.rawValue) -> RectSize {
        
        RectSize(
            width: getDoubleRandom(from: 0, to: maxWidth),
            height: getDoubleRandom(from: 0, to: maxHeight)
        )
    }
    
    func generateRandomRGBColor() -> RectRGBColor {
        var randomColorValue: ColorValue {
            ColorValue(value: getDoubleRandom(from: 0, to: RectRGBColor.maxValue))
        }
        return RectRGBColor(r: randomColorValue, g: randomColorValue, b: randomColorValue)
    }
}
