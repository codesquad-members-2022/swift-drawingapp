//
//  RectangleArray.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

struct Plane{
    private var rectangles: [Rectangle] = []
    
    subscript(index: Int) -> Rectangle?{
        guard rectangles.count > index else{
            return nil
        }
        return rectangles[index]
    }
    
    mutating func makeRectangle(maxWidth: Double, maxHeight: Double) -> Rectangle{
        let rectFactory = RectangleFactory()
        
        let rectangle = Rectangle(id: IDFactory.makeID(), size: rectFactory.makeSize(), point: rectFactory.makePoint(viewWidth: maxWidth, viewHeight: maxHeight), color: rectFactory.makeColor(), alpha: rectFactory.makeAlpha())
        
        self.rectangles.append(rectangle)
        return rectangle
    }
   
    func count() -> Int{
        return rectangles.count
    }
    
    func findRectangle(withX: Double, withY: Double) -> Rectangle?{
        guard !rectangles.isEmpty else{
            return nil
        }
        
        var findedRectangle: Rectangle?
        
        rectangles.forEach{ rectangle in
            guard let inRangeRectangle = rectangle.findLocationRange(xPoint: withX, yPoint: withY) else{
                return
            }
            findedRectangle = inRangeRectangle
        }
        
        return findedRectangle
    }
    
    func findRectangleIndex(rectangle: Rectangle) -> Int?{
        guard let index = rectangles.firstIndex(where: { $0 === rectangle }) else{
            return nil
        }
        
        return index
    }
}
