//
//  ImageRectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//


final class ImageRectangle:CustomStringConvertible,Rectangle {
    
    var description: String {
        return "\(id), \(origin), \(size), \(alpha)"
    }
    
    var id:ID
    var origin:Point
    var size:Size
    var alpha:Alpha
    
    init(id:ID,origin:Point,size:Size, alpha:Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
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
