//
//  Plane.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/07.
//

import Foundation


class Plane{
    
    private var rectangles: [Rectangle] = []
    var selectedRectangle: Rectangle?
    
    func count() -> Int{
        return rectangles.count
    }
    
    func getRectangle(index: Int) -> Rectangle{
        return rectangles[index]
    }
    
    func add(rectangle: Rectangle){
        rectangles.append(rectangle)
        NotificationCenter.default.post(name: .rectangleDidAdd, object: self, userInfo: [UserInfo.updateRectangle:rectangle])
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
        guard let selected = selectedRectangle else { return }
        selected.changedBackGroundColor(to: color)
        NotificationCenter.default.post(name: .backgroundDidChagned, object: self, userInfo: [UserInfo.updateRectangle:selected])
         
    }
    
    func changeAlpha(value : Int){
        guard let selected = selectedRectangle else { return }
        selected.changedAlpha(to: value)
        NotificationCenter.default.post(name: .alpahDidChanged, object: self, userInfo: [UserInfo.updateRectangle:selected])
    }
  
    func setSelectedRectangle(_ selected: Rectangle){
        if selected != selectedRectangle {
            self.selectedRectangle = selected
            
            NotificationCenter.default.post(name: .rectangleDidMutate, object: self, userInfo: [UserInfo.updateRectangle:selected])
        
        }
    }
    
}
