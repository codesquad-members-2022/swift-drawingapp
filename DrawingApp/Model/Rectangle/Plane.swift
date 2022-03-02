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
            let minX: Double = rectangle.showPoint().xValue()
            let maxX: Double = minX + rectangle.showSize().widthValue()
            let minY: Double = rectangle.showPoint().yValue()
            let maxY: Double = minY + rectangle.showSize().heightValue()
            
            if withX >= minX, withX <= maxX, withY >= minY, withY <= maxY{
                findedRectangle = rectangle
            }
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
