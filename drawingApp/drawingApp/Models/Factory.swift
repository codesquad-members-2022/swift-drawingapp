//
//  CreateRectangle.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//


/*
 목적 : 모델 클래스의 생성자에서 랜덤값을 처리하는 게 아니라, 랜덤값을 생성해서 모델 생성하는 초기값을 넘겨주는 팩토리를 구현한다.
 요구사항 : 
 - 고유아이디는 랜덤값으로 3자리-3자리-3자리 형태
 - W150 x H120
 - 랜덤한 위치에 랜덤 컬러로 추가
 - 배경색도 UIColor나 CGClor를 사용하면 안되며, RGB 각각 0부터 255 사이 값으로 처리한다.
 - 투명도는 1-10사이값으로 10단계로 표현한다.
*/


import Foundation
import UIKit

struct Factory {
       
    static func makeRect(planePoint : Point, planeSize : Size, modelSize : Size) -> Model {
        return  Model(id: RandomGenerator.makeId(), size: Size(width: modelSize.width, height: modelSize.height), point: RandomGenerator.makePoint(minPoint: Point(x: planePoint.x, y: planePoint.y), maxPoint: Point(x: planeSize.width - modelSize.width, y: planeSize.height - modelSize.height)), color: RandomGenerator.makeColor(), alpha: RandomGenerator.makeAlpha())
    }
    
    static func makeView(with model : Model) -> RectangleView {
        let modelView = RectangleView(frame: CGRect(x: model.point.x.trim, y: model.point.y.trim, width: model.size.width, height: model.size.height))
        
        modelView.backgroundColor = UIColor(red: model.color.red.scaleRGB, green: model.color.green.scaleRGB, blue: model.color.blue.scaleRGB, alpha: model.alpha.value)
        return modelView
    }
}
