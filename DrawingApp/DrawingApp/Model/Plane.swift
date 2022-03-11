//
//  Plane.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/07.
//

import Foundation

protocol PlaneDelegate {
    func RectangleDidAdd(_ rectangle: Rectangle)
    func BackgroundDidChanged()
}


struct Plane{
    
    var delegate: PlaneDelegate?
    private var rectangles: [Rectangle] = []
    var selectedRectangle: Rectangle?
    
    func count() -> Int{
        return rectangles.count
    }
    
    func getRectangle(index: Int) -> Rectangle{
        return rectangles[index]
    }
    
    mutating func add(rectangle: Rectangle){
        rectangles.append(rectangle)
        delegate?.RectangleDidAdd(rectangle)
    }
    
    func ExistRectangle(at point: Point) -> Rectangle?{
     
        for rect in rectangles {
            if (rect.leftTopPoint.x <= point.x && rect.leftTopPoint.y <= point.y) && (rect.rightBottomPoint.x >= point.x && rect.rightBottomPoint.y >= point.y) {
                return rect
                }
            }
        return nil
    }
    
    func changeBackgroundColor(to color: Color){
        selectedRectangle?.changedBackGroundColor(to: color)
        // 배경색 모델이 바뀌었으므로 컨트롤러에게 전달
        delegate?.BackgroundDidChanged()
        
    }
    

    
}
