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
    
    func rectPointGenerator(maxPointX: Double, maxPointY: Double) -> RectPoint {
        (
            x: randomDouble(from: 0, to: maxPointX),
            y: randomDouble(from: 0, to: maxPointY)
        )
    }
    
    func rectSizeGenerator(maxWidth: Double, maxHeight: Double) -> RectSize {
        (
            width: randomDouble(from: 0, to: maxWidth),
            height: randomDouble(from: 0, to: maxHeight)
        )
    }
    
    func rectRGBPointGenerator(maxR: Double, maxG: Double, maxB: Double) -> RectRGBColor {
        (
            r: randomDouble(from: 0, to: maxR),
            g: randomDouble(from: 0, to: maxG),
            b: randomDouble(from: 0, to: maxB)
        )
    }
}
