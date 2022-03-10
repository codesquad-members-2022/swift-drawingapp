//
//  Plane.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/07.
//

import Foundation

protocol PlaneDelegate {
    func addRectangle(_ rectangle: Rectangle)
    func selectedRectangle(_ rectangle: Rectangle)
}


struct Plane{
    
    var delegate: PlaneDelegate?
    private var rectangles: [Rectangle] = []
    
    func count() -> Int{
        return rectangles.count
    }
    
    func getRectangle(index: Int) -> Rectangle{
        return rectangles[index]
    }
    
    mutating func add(rectangle: Rectangle){
        rectangles.append(rectangle)
        delegate?.addRectangle(rectangle)
    }
    
    func isExistRectangle(_ point: Point) -> Rectangle?{
     
        for rect in rectangles {
            if (rect.leftTopPoint.x <= point.x && rect.leftTopPoint.y <= point.y) && (rect.rightBottomPoint.x >= point.x && rect.rightBottomPoint.y >= point.y) {
                return rect
                }
            }
        return nil
    }
    

    
}
