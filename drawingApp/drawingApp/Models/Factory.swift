//
//  CreateRectangle.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//


import Foundation
import UIKit
//MARK: 기존 정적 팩토리 에서 -> 추상 생산자(protocol) 를 만들어 구상 생산자 (팩토리)를 구현
/*
기존 VC 에서 사각형 생성 버튼이 눌렸을때 정적 메소드가 호출되어 모델을 만들어주는 것은 -> Tightly coupled 했음.
따라서 추상 생산자 를 구현하여 VC 에 역주입 해줄 예정.
*/


protocol ModelProducible  {
    var referencePoint : Point {get}
    var boarderSize : Size {get}
    init (referecePoint: Point, boarderSize : Size)
    func make(size : Size) -> Model
}

protocol ViewProducible {
    func make(model:Model) -> UIView
}

struct ModelFactory: ModelProducible {

    let referencePoint: Point
    let boarderSize: Size
    
    init(referecePoint: Point, boarderSize: Size) {
        self.referencePoint = referecePoint
        self.boarderSize = boarderSize
    
    }

    func make(size : Size) -> Model {
        Model(id: RandomGenerator.makeId(), size: Size(width: size.width, height: size.height), point: RandomGenerator.makePoint(minPoint: Point(x: referencePoint.x, y: referencePoint.y), maxPoint: Point(x: boarderSize.width - size.width, y: boarderSize.height - size.height)), color: RandomGenerator.makeColor(), alpha: RandomGenerator.makeAlpha())
    }
}
  
struct ViewFactory : ViewProducible {

    func make(model : Model) -> UIView {
        let modelView = RectangleView(frame: CGRect(x: model.point.x.trim, y: model.point.y.trim, width: model.size.width, height: model.size.height))
        
        modelView.backgroundColor = UIColor(red: model.color.red.scaleRGB, green: model.color.green.scaleRGB, blue: model.color.blue.scaleRGB, alpha: model.alpha.scaledValue)
        return modelView
    }

    
}
       
    
  
