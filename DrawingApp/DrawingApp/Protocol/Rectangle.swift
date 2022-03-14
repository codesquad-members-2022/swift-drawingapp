//
//  Rectangle0.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

//사각형의 기본이 되려면 밑과같은 프로퍼티가 기본적으로 있어야 할것 같아 protocol로 선언했습니다.
protocol Rectangle {
    var id:ID { get set}
    var origin:Point { get set}
    var size:Size { get set}
    var alpha:Alpha { get set}
    var rgb:RGB { get set }
}
