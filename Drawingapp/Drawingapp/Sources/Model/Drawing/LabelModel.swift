//
//  LabelModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation

protocol Textable: Drawingable {
    var font: Font { get }
    var text: String { get }
    func update(fontName: String)
}

class LabelModel: DrawingModel, Textable, Viewable {
    public private(set) var font: Font
    public private(set) var text: String
    
    override var description: String {
        "id: ( \(id) ), \(origin), \(size), alpha: \(alpha), text: \(text)"
    }
    
    var displayName: String {
        "Text \(index)"
    }
    
    var iconName: String {
        "ic_text"
    }
    
    init(id: String, index: Int, origin: Point, size: Size, alpha: Alpha, text: String, font: Font, fontColor: Color) {
        self.text = text
        self.font = font
        super.init(id: id, index: index, origin: origin, size: size, alpha: alpha)
    }
    
    func update(fontName: String) {
        self.font = Font(name: fontName, size: self.font.size)
    }
}
