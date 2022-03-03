//
//  Plane.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation

class Plane {
    private var properties = [ViewRandomProperty]()
    
    func addProperties(_ model: ViewRandomProperty) {
        properties.append(model)
    }
    
    func getRectangleCount() -> Int {
        properties.count
    }
    
    func getRectangleProperty(at index: Int) -> ViewRandomProperty? {
        guard properties.count-1 >= index else {
            return nil
        }
        
        return properties[index]
    }
    
    func hasAnyRectangle(in rect: RectPoint) -> Bool {
        properties.contains {
            $0.point.x >= rect.x
            && $0.point.y >= rect.y
            && $0.point.x+$0.size.width <= rect.x
            && $0.point.y+$0.size.height <= rect.y
        }
    }
}
