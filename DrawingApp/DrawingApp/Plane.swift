//
//  Plane.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/07.
//

import Foundation


struct Plane{
    
    var rectangles: [Rectangle] = []
    
    func count() -> Int{
        return rectangles.count
    }
    
    func getRectangle(index: Int) -> Rectangle{
        return rectangles[index]
    }
    
    mutating func add(rectangle: Rectangle){
        rectangles.append(rectangle)
    }
    
    func isExist(_ point: Point) -> Bool{
        
        for rect in rectangles {
            if (rect.leftTopPoint.x >= point.x && rect.leftTopPoint.y >= point.y) && (rect.rightBottomPoint.x <= point.x && rect.rightBottomPoint.y <= point.y) {
                return true
                }
            }
        return false
    }
    
}
