//
//  ViewSize.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

struct ViewSize{
    private var width: Int
    private var height: Int

    init(width: Int, height: Int){
        self.width = width
        self.height = height
    }
    
    func widthValue() -> Int{
        return width
    }
    
    func heightValue() -> Int{
        return height
    }
}
extension ViewSize: CustomStringConvertible{
    var description: String {
        return "W\(width), H\(height)"
    }
}
