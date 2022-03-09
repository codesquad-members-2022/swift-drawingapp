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
    
    private var images: [Image] = []
    
    subscript(index: Int) -> Image?{
        guard images.count > index && index >= 0 else{
            return nil
        }
        return images[index]
    }
    
    func addImage(imageRectangle: Image){
        self.images.append(imageRectangle)
        NotificationCenter.default.post(name: ImagePlane.makeImageRectangle, object: self, userInfo: [ImagePlane.userInfoKey : imageRectangle])
    }
    
    func count() -> Int{
        return images.count
    }
    
    func findImage(withX: Double, withY: Double) -> Bool{
        guard !images.isEmpty else{
            return false
        }
        
        var findedImage: Image?
        
        for image in images {
            guard image.findLocationRange(xPoint: withX, yPoint: withY) else{
                continue
            }

            findedImage = image
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
