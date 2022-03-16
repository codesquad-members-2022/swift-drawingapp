//
//  RectangleModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

class RectangleModel: DrawingModel, Colorable, Viewable {
    private static var makeCount: Int = 0
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
}

extension RectangleModel: ColorUpdatable {
    func update(color: Color?) {
        guard let color = color else {
            return
        }
        self.color = color
    }
}

extension RectangleModel: DrawingModelFactoryable {
    static func make(id: String, origin: Point, size: Size, alpha: Alpha, data: [Any]) -> DrawingModel {
        makeCount += 1
        let color = Color(using: RandomColorGenerator())
        return RectangleModel.init(id: id, index: makeCount, origin: origin, size: size, color: color, alpha: alpha)
    }
}
