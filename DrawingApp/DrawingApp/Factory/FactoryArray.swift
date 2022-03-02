//
//  FactoryArray.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/02.
//

import Foundation

class FactoryArray: Factory {
    
    func createRectanleArray() -> String {
        var rectangleArray = String()
        for number in 1...4 {
            let tempRactangle = "Rect\(number) \(self.description)\n"
            rectangleArray += tempRactangle
        }
        return rectangleArray
    }
}
