//
//  Plane.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/10.
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
    
    private var rectangles: [Rectangle] = []
    private var images: [Image] = []
    
    subscript(rectangleIndex: Int) -> Rectangle?{
        guard rectangles.count > rectangleIndex && rectangleIndex >= 0 else{
            return nil
        }
        return rectangles[rectangleIndex]
    }
    
    subscript(imageIndex: Int) -> Image?{
        guard images.count > imageIndex && imageIndex >= 0 else{
            return nil
        }
        return images[imageIndex]
    }
    
    func addValue(rectangle: Rectangle){
        self.rectangles.append(rectangle)
        NotificationCenter.default.post(name: Plane.NotificationName.makeRectangle, object: self, userInfo: [Plane.NotificationName.userInfoKeyRectangle : rectangle])
    }
    
    func addValue(image: Image){
        self.images.append(image)
        NotificationCenter.default.post(name: Plane.NotificationName.makeImage, object: self, userInfo: [Plane.NotificationName.userInfoKeyImage : image])
    }
    
    func rectangleCount() -> Int{
        return rectangles.count
    }
    
    func imageCount() -> Int{
        return images.count
    }
    
    func findRectangle(withX: Double, withY: Double){
        guard !rectangles.isEmpty || !images.isEmpty else{
            NotificationCenter.default.post(name: Plane.NotificationName.noneSelect, object: self)
            return
        }
        
        var findedRectangle: Rectangle?
        var findedImage: Image?
        
        for rectangle in rectangles.reversed(){
            guard rectangle.findLocationRange(xPoint: withX, yPoint: withY) else{
                continue
            }

            findedRectangle = rectangle
            break
        }
        
        for image in images.reversed(){
            guard image.findLocationRange(xPoint: withX, yPoint: withY) else{
                continue
            }

            findedImage = image
            break
        }
        
        if let rectangle = findedRectangle, let image = findedImage{
            rectangle.madeTime > image.madeTime ? NotificationCenter.default.post(name: Plane.NotificationName.selectRectangle, object: self, userInfo: [Plane.NotificationName.userInfoKeyRectangle : rectangle]) : NotificationCenter.default.post(name: Plane.NotificationName.selectImage, object: self, userInfo: [Plane.NotificationName.userInfoKeyImage : image])
        } else if let rectangle = findedRectangle{
            NotificationCenter.default.post(name: Plane.NotificationName.selectRectangle, object: self, userInfo: [Plane.NotificationName.userInfoKeyRectangle : rectangle])
        } else if let image = findedImage{
            NotificationCenter.default.post(name: Plane.NotificationName.selectImage, object: self, userInfo: [Plane.NotificationName.userInfoKeyImage : image])
        } else{
            NotificationCenter.default.post(name: Plane.NotificationName.noneSelect, object: self)
        }
    }
}
