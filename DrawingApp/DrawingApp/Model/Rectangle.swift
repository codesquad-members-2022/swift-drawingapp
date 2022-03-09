//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class Rectangle:CustomStringConvertible {
    
    var description: String {
        return "\(id), \(origin), \(size),\(rgb), \(alpha)"
    }
    
    let id:ID
    let origin:Point
    let size:Size
    var rgb:RGB
    var alpha:Alpha
    
    init(id:ID,origin:Point,size:Size,backGroundColor:RGB, alpha:Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.rgb = backGroundColor
        self.alpha = alpha
    }
    
}

//선택한 Rectangle모델을 찾기위해 Dictionary를 선언했기에 Hashable프로토콜을 채택한다.
extension Rectangle:Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        lhs.id == rhs.id
    }
}

