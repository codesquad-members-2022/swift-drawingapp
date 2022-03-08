//
//  RectangleArray.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation
import UIKit

struct Plane{
    static let makeRectangle = Notification.Name("makeRectangle")
    static let selectRectangle = Notification.Name("selectRectangle")
    static let userInfoKey: String = "rectangle"
    
    private var rectangles: [Rectangle] = []
    
    subscript(index: Int) -> Rectangle?{
        guard rectangles.count > index && index >= 0 else{
            return nil
        }
        return rectangles[index]
    }
    
    mutating func addRectangle(rectangle: Rectangle){
        self.rectangles.append(rectangle)
        NotificationCenter.default.post(name: Plane.makeRectangle, object: self, userInfo: [Plane.userInfoKey : rectangle])
    }
    
    func count() -> Int{
        return rectangles.count
    }
    
    func findRectangle(withX: Double, withY: Double){
        guard !rectangles.isEmpty else{
            return
        }
        
        var findedRectangle: Rectangle?
        
        for rectangle in rectangles{
            guard rectangle.findLocationRange(xPoint: withX, yPoint: withY) else{
                continue
            }

            findedRectangle = rectangle
            break
        }
        
        NotificationCenter.default.post(name: Plane.selectRectangle, object: self, userInfo: [Plane.userInfoKey : findedRectangle as Any])
    }
}
