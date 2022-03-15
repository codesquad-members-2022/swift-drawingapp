//
//  RectangleModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

class RectangleModel: DrawingModel, Colorable, Viewable {    
    public private(set) var color: Color
    
    override var description: String {
        "id: ( \(id) ), \(origin), \(size), \(color), alpha: \(alpha)"
    }
    
    var displayName: String {
        "Rect \(index)"
    }
    
    var iconName: String {
        "ic_rectangle"
    }
    
    init(id: String, index: Int, origin: Point, size: Size, color: Color, alpha: Alpha) {
        self.color = color
        super.init(id: id, index: index, origin: origin, size: size, alpha: alpha)
    }
    
    func update(color: Color) {
        self.color = color
    }
}
