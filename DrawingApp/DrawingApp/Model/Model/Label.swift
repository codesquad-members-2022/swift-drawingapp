//
//  Label.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/11.
//

import Foundation

class Label: Layer {
    private(set) var text: String
    private(set) var fontSize: Float
    
    init(title: String, id: ID, origin: Point, size: Size, text: String, fontSize: Float) {
        self.text = text
        self.fontSize = fontSize
        super.init(title: title, id: id, origin: origin, size: size)
    }
}

extension Label: TextMutable {
    func set(to text: String) {
        self.text = text
    }
}

extension Label: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(origin), \(size), \(text), \(fontSize)p"
    }
}
