//
//  Retangleable.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

//사각형의 기본 메서드 프로토콜.
protocol Rectangleable {
    func changeOrigin(_ origin:Point)
    func changeSize(_ size:Size)
    func changeAlpha(_ alpha:Alpha)
}
