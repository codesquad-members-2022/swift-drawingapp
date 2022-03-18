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
                userInfo:[Image.UserInfoKey.addedRectangle: rect]
        )
        return rect
    }
    
    //특정 좌표에 맞는 retangle을 찾고 seletedRectangle에 대입합니다.
    func findSeletedRectangle(point:Point) {
        let x = point.x
        let y = point.y
        
        let foundRectangle = imageRectangles.last {
            $0.origin.x <= x && $0.origin.y <= y && $0.size.width + $0.origin.x >= x && $0.size.height + $0.origin.y >= y
        }
        guard let foundRectangle = foundRectangle else { return }

        self.selectedImageRectangle = foundRectangle
        
        NotificationCenter.default.post(
            name: Image.NotificationName.didFindRectangle,
            object: self,
            userInfo: [Image.UserInfoKey.foundRectangle:foundRectangle]
        )
    }
    
    
    
    
    //Image.UserInfoKey와
    enum UserInfoKey {
        case addedRectangle
        case foundRectangle
        case changedAlpha
    }
    
   //NotificationNames
    struct NotificationName {
        static let didchangeRectangleAlpha = Notification.Name("didChangeRectangleAlpha")
        static let didAddRectangle = Notification.Name("didAddRectangle")
        static let didFindRectangle = Notification.Name("didFindRectangle")
    }
    
}
