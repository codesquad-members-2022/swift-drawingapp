//
//  ViewSize.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

struct ViewSize{
    let width: Int
    let height: Int

    init(width: Int, height: Int){
        self.width = width
        self.height = height
    }
}
extension ViewSize: CustomStringConvertible{
    var description: String {
        return "W\(width), H\(height)"
    }
}
