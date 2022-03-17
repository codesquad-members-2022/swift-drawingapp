//
//  Plane.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/11.
//

import Foundation

final class Plane{
    enum NotificationName{
        static let makeRectangle = Notification.Name("makeRectangle")
        static let makeImage = Notification.Name("makeImage")
        static let selectValue = Notification.Name("selectValue")
        static let noneSelect = Notification.Name("noneSelect")
        
        static let changeSize = Notification.Name("changeSize")
        static let changePoint = Notification.Name("changePoint")
        static let changeAlpha = Notification.Name("changeAlpha")
        static let changeColor = Notification.Name("changeColor")
        
        static let userInfoKey: String = "rectValue"
    }
    
    private var values: [RectValue] = []
    private(set) var selectedValue: RectValue?
    
    subscript(index: Int) -> RectValue?{
        guard values.count > index && index >= 0 else{
            return nil
        }
        return values[index]
    }
    
    func addValue(rectangle: Rectangle){
        self.values.append(rectangle)
        NotificationCenter.default.post(name: Plane.NotificationName.makeRectangle, object: self, userInfo: [Plane.NotificationName.userInfoKey : rectangle])
    }
    
    func addValue(image: Image){
        self.values.append(image)
        NotificationCenter.default.post(name: Plane.NotificationName.makeImage, object: self, userInfo: [Plane.NotificationName.userInfoKey : image])
    }
    
    func count() -> Int{
        return values.count
    }
    
    func getSelectedValue(value: RectValue?){
        self.selectedValue = value
    }
    
    func findValue(withX: Double, withY: Double){
        guard !values.isEmpty else{
            NotificationCenter.default.post(name: Plane.NotificationName.noneSelect, object: self)
            return
        }
        
        var findedValue: RectValue?
        
        for value in values.reversed(){
            guard value.findLocationRange(xPoint: withX, yPoint: withY) else{
                continue
            }

            findedValue = value
            break
        }
        
        if let value = findedValue{
            NotificationCenter.default.post(name: Plane.NotificationName.selectValue, object: self, userInfo: [Plane.NotificationName.userInfoKey : value])
        } else{
            NotificationCenter.default.post(name: Plane.NotificationName.noneSelect, object: self)
        }
    }
}

extension Plane{
    func changeRectValuePoint(newPoint: MyPoint){
        guard let rectValue = selectedValue else{
            return
        }
        
        rectValue.changePoint(point: newPoint)
        
        NotificationCenter.default.post(name: Plane.NotificationName.changePoint, object: self)
    }
    
    func changeRectValueSize(newSize: MySize){
        guard let rectValue = selectedValue else{
            return
        }
        
        rectValue.changeSize(size: newSize)
        
        NotificationCenter.default.post(name: Plane.NotificationName.changeSize, object: self)
    }
    
    func changeRectValueAlpha(newAlpha: Alpha){
        guard let rectValue = selectedValue else{
            return
        }
        
        rectValue.changeAlpha(alpha: newAlpha)
        
        NotificationCenter.default.post(name: Plane.NotificationName.changeAlpha, object: self)
    }
    
    func changeRectangleColor(newColor: RGBColor){
        guard let rectangle = selectedValue as? Rectangle else{
            return
        }
        
        rectangle.changeColor(color: newColor)
        
        NotificationCenter.default.post(name: Plane.NotificationName.changeColor, object: self)
    }
}
