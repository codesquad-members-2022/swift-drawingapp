//
//  ViewSize.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

class ViewSize: NSObject{
    let width: Int
    let height: Int
    override var description: String {
        return "W\(width), H\(height)"
    }
    init(width: Int, height: Int){
        self.width = width
        self.height = height
    }
}
