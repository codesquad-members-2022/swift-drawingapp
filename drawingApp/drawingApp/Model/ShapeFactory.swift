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


//Rectangle 를 만들어주는 팩토리
class ShapeFactory {
   
    //이미 정해저 있는 사각형의 크기는 상수로 정의.
    private let width: Double
    private let height: Double
    //아이패드에 사각형을 그릴수있는 좌표정보
    private let minX: Double = 0
    private let minY: Double = 20
    private let maxX: Double
    private let maxY: Double
    
    //상위 모듈에서 현재 스크린의 폭과 높이 를 받아와서 모형이 그려질 경계선을 설정한다.
    init(screenWidth: Double , screenHeight : Double, shapeSize : Size) {
        self.width = shapeSize.width
        self.height = shapeSize.height
        self.maxX = screenWidth -  self.width
        self.maxY = screenHeight - self.height
    }
    //550e8400-e29b-41d4-a716–446655440000 의 UUID 형태에서 -> 29b-1d4-716 과 같은식으로 랜덤 id 생성.
    func generateRandomId() -> String {
        var UUID = UUID().uuidString.components(separatedBy: "-")
        for i in 1..<4 {
            UUID[i].removeFirst()
        }
        return UUID[1..<4].joined(separator:"-")
    }

    func generateRandomPoint() -> Point {
        let x = Double.random(in: minX..<maxX)
        let y = Double.random(in: minY..<maxY)
        return Point(x: x, y: y)
    }
    
    
    func generateRandomColor() -> Color {
        let red = Double.random(in: 0..<255)
        let green = Double.random(in: 0..<255)
        let blue = Double.random(in: 0..<255)
        return Color(r: red, g: green, b: blue)
    }
    
    func generateRandomAlpha() -> Alpha {
        return Alpha.allCases.randomElement()!
    }
    
    
    func makeRect() throws-> Rectangle{
        if maxX <= minX || maxY <= minY {
            throw Errors.notValidScreenSize
        }
        let rect =  Rectangle(id: generateRandomId(), size: Size(width: width, height: height), point: generateRandomPoint(), color: generateRandomColor(), alpha: generateRandomAlpha())
       return rect

    }
    
    
    enum Errors : Error {
        case notValidScreenSize
    }
    
}


