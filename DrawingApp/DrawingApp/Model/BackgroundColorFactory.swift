//
//  BackgroundColorFactory.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/06.
//

import Foundation

class BackgroundColorFactory {
    public static func generateRandomColor() -> BackgroundColor? {
        
        let red = BackgroundColor.possibleColorValues.randomElement() ?? 0
        let green = BackgroundColor.possibleColorValues.randomElement() ?? 0
        let blue = BackgroundColor.possibleColorValues.randomElement() ?? 0

        return BackgroundColor(r: red, g: green, b: blue)
    }
}
