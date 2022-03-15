//
//  ImageRectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

import UIKit

//Rectangle의 구조를 따르지만, Image프로퍼티가 추가되어있는 Class가 ImageRectangle이라 생각하여 선언.
final class ImageRectangle:Rectangle {

    private let id:ID
    private(set) var origin:Point
    private(set) var size:Size
    private(set) var alpha:Alpha
    private(set) var image:Data?
    
    init(id: ID, origin: Point, size: Size, rgb: RGB, alpha: Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.alpha = alpha
    }

    func changeOrigin(_ origin: Point) {
        self.origin = origin
    }
    
    func changeSize(_ size: Size) {
        self.size = size
    }
    
    func changeAlpha(_ alpha: Alpha) {
        self.alpha = alpha
    }
    
}

//선택한 Rectangle모델을 찾기위해 Dictionary를 선언했기에 Hashable프로토콜을 채택한다.
extension ImageRectangle:Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    //이미지가 같은면 같은 사각형.
    static func == (lhs: ImageRectangle, rhs: ImageRectangle) -> Bool {
        lhs.image == rhs.image
    }
}
