//
//  BackgroundColorFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/06.
//

import Foundation

class BackgroundColorFactory {
    public static func makeRandomBackgroundColor() -> BackgroundColor {
        let red = Int.random(in: BackgroundColor.possibleColorValues)
        let green = Int.random(in: BackgroundColor.possibleColorValues)
        let blue = Int.random(in: BackgroundColor.possibleColorValues)

        return BackgroundColor(r: red, g: green, b: blue) ?? BackgroundColor(r: 0, g: 0, b: 0)!
    }
}
