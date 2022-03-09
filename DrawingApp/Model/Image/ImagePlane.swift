//
//  ImageRectanglePlain.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/08.
//

import Foundation

final class ImagePlane{
    static let makeImageRectangle = Notification.Name("makeImage")
    static let selectRectangle = Notification.Name("selectImage")
    static let noneSelectRectangle = Notification.Name("noneSelectImage")
    static let userInfoKey: String = "image"
    
    private var imageRectangle: [Image] = []
    
    subscript(index: Int) -> Image?{
        guard imageRectangle.count > index && index >= 0 else{
            return nil
        }
        return imageRectangle[index]
    }
    
    func addImage(imageRectangle: Image){
        self.imageRectangle.append(imageRectangle)
        NotificationCenter.default.post(name: ImagePlane.makeImageRectangle, object: self, userInfo: [ImagePlane.userInfoKey : imageRectangle])
    }
    
    func count() -> Int{
        return imageRectangle.count
    }
    
    func findImage(withX: Double, withY: Double) -> Bool{
        guard !imageRectangle.isEmpty else{
            return false
        }
        
        var findedImage: Image?
        
        for imageRectangle in imageRectangle {
            guard imageRectangle.findLocationRange(xPoint: withX, yPoint: withY) else{
                continue
            }

            findedImage = imageRectangle
            break
        }
        
        if let image = findedImage{
            NotificationCenter.default.post(name: ImagePlane.selectRectangle, object: self, userInfo: [ImagePlane.userInfoKey : image])
            return true
        } else{
            return false
        }
    }
}
