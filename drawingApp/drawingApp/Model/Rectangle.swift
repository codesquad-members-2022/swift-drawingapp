//
//  Rectangle.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//

/*
목적: 사각형 뷰를 표현하는 모델 클래스(class)를 설계한다.
요구사항 : 고유아이디(String), 크기(Width, Height), 위치(X, Y), 배경색(R, G, B), 투명도(Alpha)

고유아이디는 랜덤값으로 3자리-3자리-3자리 형태

크기는 CGSize를 사용하면 안되며, Double 타입을 기준으로 처리한다. 필요하면 Size 타입을 선언해도 된다.

위치는 CGPoint를 사용하면 안되며, Double 타입을 기준으로 처리한다. 필요하면 Point 타입을 선언해도 된다.

배경색도 UIColor나 CGClor를 사용하면 안되며, RGB 각각 0부터 255 사이 값으로 처리한다.

투명도는 1-10사이값으로 10단계로 표현한다.
*/

import Foundation

//뷰에 나타날 사각형의 데이터.
class Rectangle {
    //사각형에 대한 모든 속성을 가지고 있다
    private var `id` : String
    private var size : Size
    private var point : Point
    private var color : Color
    private var alpha : Double
    
    
    init (id: String, size:Size, point: Point, color: Color, alpha : Double) {
        self.id = id
        self.size = size
        self.point = point
        self.color = color
        self.alpha = alpha
    }
    
    //Getters
    func getId() -> String {
        self.id
    }
    
    func getSize() -> Size {
        self.size
    }
    
    func getPoint() -> Point {
        self.point
    }
    
    func getColor() -> Color {
        self.color
    }
    
    func getAlpha() -> Double {
        self.alpha
    }
}


//형태 : (fxd-0fz-4b9), X:10,Y:200, W150, H120, R:245, G:0, B:245, Alpha: 9
extension Rectangle : CustomStringConvertible {
    var description: String {
        return "(\(id)), \(point), \(size), \(color), Alpha:\(alpha)"
    }
}


//Size 타입 정의
struct Size : CustomStringConvertible {
    var width : Double = 150
    var height : Double = 120
    var description: String {
        return "W\(width), H\(height)"
    }
}

//Point (좌표) 타입 정의
struct Point : CustomStringConvertible {
    var x : Double = 0
    var y : Double = 0
    var description: String {
        return "X:\(x), Y:\(y)"
    }
}

//Color (RGB) 타입 정의
struct Color : CustomStringConvertible {
    var red : Double = 0
    var green : Double = 0
    var blue : Double = 0
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
}



