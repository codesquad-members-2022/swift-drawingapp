//
//  RectangleCreator.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

protocol RectangleCreator {
    func makeRectangle(type:Rectangleable.Type) -> Rectangleable 
}
