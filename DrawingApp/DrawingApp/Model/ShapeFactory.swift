//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class ShapeFactory: ShapeCreator {
    func createRectangle(point: Point, size: Size, color: Color, alpha: Alpha) -> Shape {
        let id = generateId()
        return Rectangle(id: id, point: point, size: size, color: color, alpha: alpha)
    }
    
    private func generateId() -> String {
        let uuidId = UUID().uuidString.split(separator: "-").joined(separator: "")
        let thirdIndex = uuidId.index(uuidId.startIndex, offsetBy: 3)
        let sixthIndex = uuidId.index(thirdIndex, offsetBy: 3)
        let ninethIndex = uuidId.index(sixthIndex, offsetBy: 3)
        let result = uuidId[..<thirdIndex] + "-" + uuidId[thirdIndex..<sixthIndex] + "-" +  uuidId[sixthIndex..<ninethIndex]
        return String(result)
    }
}
