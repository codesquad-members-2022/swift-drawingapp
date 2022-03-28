//
//  PostIt.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/28.
//

import Foundation

class PostIt: Layer {
    private(set) var text: String
    private(set) var backgroundColor: Color
    
    init(title: String, id: ID, origin: Point, size: Size, text: String, color: Color) {
        self.text = text
        self.backgroundColor = color
        super.init(title: title, id: id, origin: origin, size: size)
    }
}

extension PostIt: TextMutable {
    var getText: String {
        self.text
    }
    
    func set(to text: String) {
        self.text = text
    }
}

extension PostIt: ColorMutable {
    var color: Color {
        self.backgroundColor
    }
    
    func set(to color: Color) {
        self.backgroundColor = color
    }
}

extension PostIt: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(origin), \(size), \(backgroundColor), \(text)"
    }
}
