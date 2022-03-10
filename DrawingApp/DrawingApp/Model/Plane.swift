//
//  Plane.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

import Foundation

public struct Plane {
    
    //Point를 기반으로 Dictionary를 만듬으로써 View에서 TapGesture로 좌표값을 넘겼을때 그에 해당하는 Rectangle을 찾을 수있다.
    var rectangles:[Point:Rectangle] = [:]
    var selectedRectangle:Rectangle?
    
    var count:Int {
        self.rectangles.count
    }
    
    //현재 선택한 rectangle 모델 alpha를 바꾸고 ViewController에게 알려주기 위해 Delegate메서드를 호출했습니다.
    func change(alpha:Alpha){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.alpha = alpha
        
    }
    
    //현재 선택한 rectangle 모델 Color를 바꾸고 ViewController에게 delegate로 알려줍니다.
    func change(color:RGB) {
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.rgb = color
        
    }
    
    //rectangle을 추가할때마다 delegate메소드를 호출합니다.
    mutating func addRectangle(rectangle:Rectangle) {
        //Double로 만들어지는 Point값이 소수점에서 미세한 차이가 생길 수 있어서 round로 한번 변환을 시켰습니다.
        let x = round(rectangle.origin.x)
        let y = round(rectangle.origin.y)
        let key = Point(x: x, y: y)
        
        rectangles[key] = rectangle
        
    }
    
    //특정 좌표에 맞는 retangle을 찾고 seletedRectangle에 대입합니다.
    mutating func findSeletedRectangle(x:Double,y:Double) {
        let convertX = round(x)
        let convertY = round(y)
        
        let key = Point(x: convertX, y: convertY)
        
        guard let selectedRectangle = rectangles[key] else { return }
        self.selectedRectangle = selectedRectangle
    
    }
}
