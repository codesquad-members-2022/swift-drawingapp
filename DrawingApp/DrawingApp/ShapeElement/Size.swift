//
//  Size.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class Size:CustomStringConvertible,Drawable {

    
    func draw() {
        print("Size Draw Width:\(width), height:\(height)")
    }
    
    var description: String {
        "W\(width), H\(height)"
    }
    
    private var width:Double
    private var height:Double
    
    //min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let maxWidth:Double = 820.0
    static let maxHeight:Double = 1180.0
    
    init(width:Double, height:Double) {
        self.width = width
        self.height = height
    }
    
}
