//
//  Sub.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/11.
//

import Foundation

final class Plane{
    enum NotificationName{
        static let makeRectangle = Notification.Name("makeRectangle")
        static let selectRectangle = Notification.Name("selectRectangle")
        static let userInfoKeyRectangle: String = "rectangle"
        
        static let makeImage = Notification.Name("makeImage")
        static let selectImage = Notification.Name("selectImage")
        static let userInfoKeyImage: String = "image"
        
        static let noneSelect = Notification.Name("noneSelect")
    }
    
    private var values: [RectValue] = []
    
    subscript(index: Int) -> RectValue?{
        guard values.count > index && index >= 0 else{
            return nil
        }
        return values[index]
    }
    
    func addValue(rectangle: Rectangle){
        self.values.append(rectangle)
        NotificationCenter.default.post(name: Plane.NotificationName.makeRectangle, object: self, userInfo: [Plane.NotificationName.userInfoKeyRectangle : rectangle])
    }
    
    func addValue(image: Image){
        self.values.append(image)
        NotificationCenter.default.post(name: Plane.NotificationName.makeImage, object: self, userInfo: [Plane.NotificationName.userInfoKeyImage : image])
    }
    
    func count() -> Int{
        return values.count
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
        
        if let rectangle = findedValue as? Rectangle{
            NotificationCenter.default.post(name: Plane.NotificationName.selectRectangle, object: self, userInfo: [Plane.NotificationName.userInfoKeyRectangle : rectangle])
        } else if let image = findedValue as? Image{
            NotificationCenter.default.post(name: Plane.NotificationName.selectImage, object: self, userInfo: [Plane.NotificationName.userInfoKeyImage : image])
        } else{
            NotificationCenter.default.post(name: Plane.NotificationName.noneSelect, object: self)
        }
    }
}
