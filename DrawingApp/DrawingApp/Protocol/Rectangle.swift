//
//  Rectangle0.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

protocol Rectangle {
    var id:ID { get set}
    var origin:Point { get set}
    var size:Size { get set}
    var alpha:Alpha { get set}
}
