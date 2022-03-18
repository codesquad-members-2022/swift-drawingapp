//
//  PlaneRectangle.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//


final class PlaneRectangle:Rectangleable {
        
    private let id:ID
    private(set) var origin:Point
    private(set) var size:Size
    private(set) var rgb:RGB
    private(set) var alpha:Alpha
    
    init(id:ID,origin:Point,size:Size,rgb:RGB, alpha:Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.rgb = rgb
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
    
    func changeColor(_ rgb:RGB) {
        self.rgb = rgb
    }
    
    
}

//선택한 Rectangle모델을 찾기위해 Dictionary를 선언했기에 Hashable프로토콜을 채택한다.
extension PlaneRectangle:Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    //기본 사각형 속성 비교.
    static func == (lhs: PlaneRectangle, rhs: PlaneRectangle) -> Bool {
        lhs.rgb == rhs.rgb && lhs.alpha == rhs.alpha && lhs.size == rhs.size
    }
}
