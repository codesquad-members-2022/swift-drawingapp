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


//모형을 만들어주는 팩토리
class ShapeFactory {
   
    //생성하려고 하는 모형의 크기
    private let width: Double
    private let height: Double
    //Boarder of Plane
    private let minX: Double = 0
    private let minY: Double = 20
    private let maxX: Double
    private let maxY: Double
    
    //상위 모듈에서 현재 스크린의 폭과 높이 를 받아와서 모형이 그려질 경계선을 설정한다.
    init(planeWidth: Double , planeHeight: Double, shapeSize: Size) {
        self.width = shapeSize.width
        self.height = shapeSize.height
        self.maxX = planeWidth - self.width
        self.maxY = planeHeight - self.height
    }
    
    func makeRect() throws -> Rectangle{
        if maxX <= minX || maxY <= minY {
            throw Errors.notValidScreenSize
        }
        return  Rectangle(id: RandomGenerator.makeId(), size: Size(width: width, height: height), point: RandomGenerator.makePoint(minPoint: Point(x: minX, y: minY), maxPoint: Point(x: maxX, y: maxY)), color: RandomGenerator.makeColor(), alpha: RandomGenerator.makeAlpha())
    }
    
    
    enum Errors : Error {
        case notValidScreenSize
    }
    
}


