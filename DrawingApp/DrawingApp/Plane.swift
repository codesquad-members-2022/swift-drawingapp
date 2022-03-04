//
//  Plane.swift
//  DrawingApp
//
//  Created by YEONGJIN JANG on 2022/03/04.
//

import Foundation

struct Plane {
    var rectangleArray: [Rectangle] = []
    var rectangleCount: Int {
        return rectangleArray.count
    }
    mutating func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle(name: <#T##String#>)
    }
}
