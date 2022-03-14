//
//  ImageRectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

import UIKit

//Rectangle의 구조를 따르지만, Image프로퍼티가 추가되어있는 Class가 ImageRectangle이라 생각하여 선언했습니다.
final class ImageRectangle:CustomStringConvertible,Rectangle {

    var description: String {
        return "\(id), \(origin), \(size), \(alpha)"
    }
    
    var id:ID
    var origin:Point
    var size:Size
    var alpha:Alpha
    var rgb: RGB
    var image:UIImage?
        
    init(id: ID, origin: Point, size: Size,rgb: RGB,alpha:Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.rgb = rgb
        self.alpha = alpha
    }

}

//선택한 Rectangle모델을 찾기위해 Dictionary를 선언했기에 Hashable프로토콜을 채택한다.
extension ImageRectangle:Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    static func == (lhs: ImageRectangle, rhs: ImageRectangle) -> Bool {
        lhs.id == rhs.id
    }
}
