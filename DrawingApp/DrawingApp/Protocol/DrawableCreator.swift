//
//  DrawableCreator.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/02.
//

//size와 point를 둘다 수평값 수직값을 이용하는 공통점이 있다고 생각해 vertical과 horizontal라는 매개변수로 묶어보았습니다.
protocol DrawableCreator {
    func makeDrawable(drawType: DrawType, horizontal:Double,vertical:Double) -> Drawable
    func makeRandomDrawable(drawType:DrawType) -> Drawable
}

