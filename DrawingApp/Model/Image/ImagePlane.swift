//
//  ImageRectanglePlain.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/08.
//

import Foundation

final class ImagePlane{
    static let makeImageRectangle = Notification.Name("makeImageRectangle")
    static let userInfoKey: String = "imageRectangle"
    
    private var imageRectangle: [Image] = []
    
    subscript(index: Int) -> Image?{
        guard imageRectangle.count > index && index >= 0 else{
            return nil
        }
        return imageRectangle[index]
    }
    
    func addRectangle(imageRectangle: Image){
        self.imageRectangle.append(imageRectangle)
        NotificationCenter.default.post(name: ImagePlane.makeImageRectangle, object: self, userInfo: [ImagePlane.userInfoKey : imageRectangle])
    }
    
    func count() -> Int{
        return imageRectangle.count
    }
    
    func findRectangle(withX: Double, withY: Double){
        guard !imageRectangle.isEmpty else{
            return
        }
        
        var findedImageRectangle: Image?
        
        for imageRectangle in imageRectangle {
            guard imageRectangle.findLocationRange(xPoint: withX, yPoint: withY) else{
                continue
            }

            findedImageRectangle = imageRectangle
            break
        }
        
        if let imageRectangle = findedImageRectangle{
            
        } else{
            
        }
    }
}
