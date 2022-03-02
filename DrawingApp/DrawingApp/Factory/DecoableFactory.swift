//
//  DecoableComponentFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/02.
//

final class DecoableFactory:DecoableCreator {
    func makeRandomDecoable(decoType: DecoType) -> Decoable {
        switch decoType {
        case .RGB:
            let randomRedValue = Int.random(in: RGB.minValue...RGB.maxValue)
            let randomGreenValue = Int.random(in: RGB.minValue...RGB.maxValue)
            let randomBlueValue = Int.random(in: RGB.minValue...RGB.maxValue)
            
            return RGB(red: randomRedValue, green: randomGreenValue, blue: randomBlueValue)
            
        case .alpha:
            let randomAlpha = Int.random(in:Alpha.minValue...Alpha.maxValue)
            
            return Alpha(alpha: randomAlpha)
        }
    }
}
