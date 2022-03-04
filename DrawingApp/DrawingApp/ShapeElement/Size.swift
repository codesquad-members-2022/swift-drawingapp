//
//  Size.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

struct Size:CustomStringConvertible{
    
    var description: String {
        "W\(width), H\(height)"
    }
    
    var width:Double
    var height:Double
    
    //min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let maxWidth:Double = 1180.0
    static let maxHeight:Double = 820.0
    
    init(width:Double, height:Double) {
        self.width = width
        self.height = height
    }
    
}
