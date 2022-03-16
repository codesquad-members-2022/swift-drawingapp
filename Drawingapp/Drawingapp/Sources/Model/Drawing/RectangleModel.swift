//
//  RectangleModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

protocol Colorable: Drawingable {
    var color: Color { get }
    func update(color: Color)
}

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

extension RectangleModel: DrawingModelFactoryable {
    static func make(id: String, origin: Point, size: Size, alpha: Alpha, data: [Any]) -> DrawingModel {
        let color = Color(using: RandomColorGenerator())
        return RectangleModel.init(id: id, index: 0, origin: origin, size: size, color: color, alpha: alpha)
    }
}
