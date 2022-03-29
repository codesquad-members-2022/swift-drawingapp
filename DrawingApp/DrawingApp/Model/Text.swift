//
//  Text.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/29.
//

import Foundation

protocol TextDataHavable {
    var text: String {get}
}

class Text: BasicShape, TextDataHavable {
    private(set) var text: String
    
    init(size: Size, point: Point, text: String, alpha: Alpha) {
        self.text = text
        super.init(size: size, point: point, alpha: alpha)
    }
}
