//
//  PlaneRectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//


final class PlaneRectangle:CustomStringConvertible,Rectangle {
    
    var description: String {
        return "\(id), \(origin), \(size),\(rgb), \(alpha)"
    }
    
    var id:ID
    var origin:Point
    var size:Size
    var rgb:RGB
    var alpha:Alpha
    
    init(id:ID,origin:Point,size:Size,rgb:RGB, alpha:Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.rgb = rgb
        self.alpha = alpha
    }
    
}

//선택한 Rectangle모델을 찾기위해 Dictionary를 선언했기에 Hashable프로토콜을 채택한다.
extension PlaneRectangle:Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    static func == (lhs: PlaneRectangle, rhs: PlaneRectangle) -> Bool {
        lhs.id == rhs.id
    }
}
