//
//  Plane.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

import Foundation

public class Plane {
    
    //Point를 기반으로 Dictionary를 만듬으로써 View에서 TapGesture로 좌표값을 넘겼을때 그에 해당하는 Rectangle을 찾을 수있다.
    private var rectangles:[Point:Rectangle] = [:]
    private var selectedRectangle:Rectangle?
    
    var count:Int {
        self.rectangles.count
    }
    
    
    func change(alpha:Alpha){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.alpha = alpha
        
        NotificationCenter.default.post(
            name: Plane.NotificationName.didchangeRectangleAlpha,
            object: self,
            userInfo: [Plane.UserInfoKey.changedAlpha:alpha]
        )
    }
    
    
    func change(color:RGB) {
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.rgb = color
        
        NotificationCenter.default.post(
            name: Plane.NotificationName.didChangeRectangleColor,
            object: self,
            userInfo: [Plane.UserInfoKey.changedColor:color]
        )
    }
    
    func addRectangle(rectangle:Rectangle) {
        //Double로 만들어지는 Point값이 소수점에서 미세한 차이가 생길 수 있어서 round로 한번 변환을 시켰습니다.
        let x = round(rectangle.origin.x)
        let y = round(rectangle.origin.y)
        let key = Point(x: x, y: y)
        
        rectangles[key] = rectangle
        NotificationCenter.default.post(
                name: Plane.NotificationName.didAddRectangle,
                object: self,
                userInfo:[Plane.UserInfoKey.addedRectangle: rectangle]
        )
    }
    
    //특정 좌표에 맞는 retangle을 찾고 seletedRectangle에 대입합니다.
    func findSeletedRectangle(x:Double,y:Double,size:Size) {
        
        checkEmptySpace(size: size)
        
        let convertX = round(x)
        let convertY = round(y)
        
        let key = Point(x: convertX, y: convertY)
        
        guard let foundRectangle = rectangles[key] else { return  }
        self.selectedRectangle = foundRectangle
        
        NotificationCenter.default.post(
            name: Plane.NotificationName.didFindRectangle,
            object: self,
            userInfo: [Plane.UserInfoKey.foundRectangle:foundRectangle as Any]
        )
    }
    
    //빈화면을 클릭할 시 아무런 정보를 가지지 않은 채로 post합니다.
    //nil값을 가진채로 Dictionary를 만들어 Userinfo를 보내도 같은 결과가 나오지만 굳이 Dictionary를 만들어 보낼 필요를 못느껴 새로운 post를 만들었습니다.
    private func checkEmptySpace(size:Size) {
        if isEmptySpace(size: size) {
            self.selectedRectangle = nil
            NotificationCenter.default.post(
                name: Plane.NotificationName.didFindRectangle,
                object: self
            )
        }
    }
    
    //Size값이 최대값을 가지고 있다면 빈 화면을 클릭한 것입니다.
    private func isEmptySpace(size:Size) -> Bool{
        let height = size.height
        let width = size.width
        let emptySpaceSize = Size(width: Size.maxWidth, height: Size.maxHeight)
        
        return emptySpaceSize == Size(width: width, height: height) ? true : false
    }
    
    
    
    //Plane.UserInfoKey와 같이 Plane과 관련있게 하고싶어서 Nested Enum을 선언했습니다.
    enum UserInfoKey {
        case addedRectangle
        case foundRectangle
        case changedColor
        case changedAlpha
    }
    
    //enum과 Struct사이에서 고민을 했으나 static let으로 선언하고 case로 선언을 하지 않을 것이라면 Struct가 더 알맞다고 생각했습니다.
    struct NotificationName {
        static let didchangeRectangleAlpha = Notification.Name("didChangeRectangleAlpha")
        static let didChangeRectangleColor = Notification.Name("didChangeRectangleColor")
        static let didAddRectangle = Notification.Name("didAddRectangle")
        static let didFindRectangle = Notification.Name("didFindRectangle")
    }
}

