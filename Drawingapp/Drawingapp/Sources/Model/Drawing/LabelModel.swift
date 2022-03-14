//
//  LabelModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation

class LabelModel: DrawingModel, Textable {
    public private(set) var font: Font
    public private(set) var fontColor: Color
    public private(set) var text: String
    
    override var description: String {
        "id: ( \(id) ), \(origin), \(size), alpha: \(alpha), text: \(text)"
    }
    
    init(id: String, index: Int, origin: Point, size: Size, alpha: Alpha, text: String, font: Font, fontColor: Color) {
        self.text = text
        self.font = font
        self.fontColor = fontColor
        super.init(id: id, index: index, origin: origin, size: size, alpha: alpha)
    }
    
    func update(text: String) {
        self.text = text
    }
    
    func update(font: Font) {
        self.font = font
    }
    
    func update(fontColor: Color) {
        self.fontColor = fontColor
    }
}
