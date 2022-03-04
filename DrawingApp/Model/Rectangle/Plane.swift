//
//  RectangleArray.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation
import UIKit

struct Plane{
    private var rectangles: [Rectangle] = []
    
    subscript(index: Int) -> Rectangle?{
        guard rectangles.count > index else{
            return nil
        }
        return rectangles[index]
    }
    
    mutating func addRectangle(rectangle: Rectangle){
        self.rectangles.append(rectangle)
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
