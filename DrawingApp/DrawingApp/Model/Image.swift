//
//  Image.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

import Foundation

//TODO: Something deal with ImageRectangle
class Image {
    
    private var imageRectangles:[ImageRectangle] = []
    private var selectedImageRectangle:ImageRectangle?
    
    var count:Int {
        self.imageRectangles.count
    }
    
    //사각형 생성,추가.
    @discardableResult
    func addRectangle(imageData:Data) -> ImageRectangle{
        let rect = RectangleFactory.makePlaneRectangle(imageData: imageData)
        imageRectangles.append(rect)
        
        NotificationCenter.default.post(
                name: Image.NotificationName.didAddRectangle,
                object: self,
                userInfo:[Image.UserInfoKey.addedImageRectangle: rect]
        )
        return rect
    }
    
    //Plane.UserInfoKey와 같이 Plane과 관련있게 하고싶어서 Nested Enum을 선언
    enum UserInfoKey {
        case addedImageRectangle
    }
    
   //NotificationNames
    struct NotificationName {
        static let didAddRectangle = Notification.Name("didAddImageRectangle")
    }
    
}
