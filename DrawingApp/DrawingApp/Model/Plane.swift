//
//  Plane.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

import Foundation

public class Plane {
    
    private var rectangles = [PlaneRectangle]()
    private var selectedRectangle:PlaneRectangle?
    
    var count:Int {
        self.rectangles.count
    }
    
    
    func change(alpha:Alpha){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlpha(alpha)
        
        NotificationCenter.default.post(
            name: Plane.NotificationName.didchangeRectangleAlpha,
            object: self,
            userInfo: [Plane.UserInfoKey.changedAlpha:alpha]
        )
    }
    
    
    func change(color:RGB) {
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeColor(color)
        
        NotificationCenter.default.post(
            name: Plane.NotificationName.didChangeRectangleColor,
            object: self,
            userInfo: [Plane.UserInfoKey.changedColor:color]
        )
    }
    
    //사각형 생성,추가.
    @discardableResult
    func addRectangle() -> PlaneRectangle{
        let rect = RectangleFactory.makePlaneRectangle()
        rectangles.append(rect)
        
        NotificationCenter.default.post(
                name: Plane.NotificationName.didAddRectangle,
                object: self,
                userInfo:[Plane.UserInfoKey.addedRectangle: rect]
        )
        return rect
    }
    
    //특정 좌표에 맞는 retangle을 찾고 seletedRectangle에 대입합니다.
    func findSeletedRectangle(point:Point) {
        let x = point.x
        let y = point.y
        
        let foundRectangle = rectangles.last {
            $0.origin.x <= x && $0.origin.y <= y && $0.size.width + $0.origin.x >= x && $0.size.height + $0.origin.y >= y
        }
        guard let foundRectangle = foundRectangle else { return }

        self.selectedRectangle = foundRectangle
        
        NotificationCenter.default.post(
            name: Plane.NotificationName.didFindRectangle,
            object: self,
            userInfo: [Plane.UserInfoKey.foundRectangle:foundRectangle]
        )
    }
    
    
    //Plane.UserInfoKey와 같이 Plane과 관련있게 하고싶어서 Nested Enum을 선언
    enum UserInfoKey {
        case addedRectangle
        case foundRectangle
        case changedColor
        case changedAlpha
    }
    
   //NotificationNames
    struct NotificationName {
        static let didchangeRectangleAlpha = Notification.Name("didChangeRectangleAlpha")
        static let didChangeRectangleColor = Notification.Name("didChangeRectangleColor")
        static let didAddRectangle = Notification.Name("didAddRectangle")
        static let didFindRectangle = Notification.Name("didFindRectangle")
    }
}

