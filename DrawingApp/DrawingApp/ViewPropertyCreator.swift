//
//  ViewPropertyCreator.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/01.
//

import Foundation

// 위치, 크기, RGB 값을 생성하는 팩토리 메소드를 포함하는 클래스입니다.
// 랜덤 값을 추출하는 RandomizeValue 를 서브클래싱 합니다.
class ViewPropertyCreator: RandomizeValue {
    
    func generateRandomPoint(maxPointX: Double, maxPointY: Double) -> RectPoint {
        RectPoint(
            x: getDoubleRandom(from: 0, to: maxPointX),
            y: getDoubleRandom(from: 0, to: maxPointY)
        )
    }
    
    func generateRandomSize(maxWidth: Double, maxHeight: Double) -> RectSize {
        RectSize(
            width: getDoubleRandom(from: 0, to: maxWidth),
            height: getDoubleRandom(from: 0, to: maxHeight)
        )
    }
    
    func generateRandomRGBColor(maxR: Double, maxG: Double, maxB: Double) -> RectRGBColor {
        RectRGBColor(
            r: getDoubleRandom(from: 0, to: maxR),
            g: getDoubleRandom(from: 0, to: maxG),
            b: getDoubleRandom(from: 0, to: maxB)
        )
    }
}
