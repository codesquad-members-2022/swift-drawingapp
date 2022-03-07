//
//  Plane.swift
//  DrawingApp
//
//  Created by YEONGJIN JANG on 2022/03/04.
//

import Foundation

class Plane {
    private var rectangleArray: [Rectangle] = []
    
    var rectangleCount: Int {
        return rectangleArray.count
    }
    
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangleArray.append(rectangle)
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangleArray[index]
    }
}
