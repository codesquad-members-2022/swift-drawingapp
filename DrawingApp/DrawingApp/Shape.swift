//
//  Shape.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class Shape {
    let id: String = {
        let uuidId = UUID().uuidString.split(separator: "-").joined(separator: "")
        let thirdIndex = uuidId.index(uuidId.startIndex, offsetBy: 3)
        let sixthIndex = uuidId.index(thirdIndex, offsetBy: 6)
        let ninethIndex = uuidId.index(sixthIndex, offsetBy: 9)
        print(uuidId)
        let result = uuidId[..<thirdIndex] + uuidId[thirdIndex...sixthIndex] + uuidId[sixthIndex...ninethIndex]
        return String(result)
    }()
    let size: Size
    let point: Point
    let backgroundColor: BackgroundColor
    let alpha: Int // 1-10 사이값
    
    init(size: Size, point: Point, backgroundColor: BackgroundColor, alpha: Int) {
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
}
