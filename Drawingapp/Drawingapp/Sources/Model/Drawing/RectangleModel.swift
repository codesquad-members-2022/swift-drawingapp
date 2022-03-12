//
//  RectangleModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

class RectangleModel: DrawingModel, Colorable {    
    public private(set) var color: Color
    
    override var description: String {
        "id: ( \(id) ), \(origin), \(size), \(color), alpha: \(alpha)"
    }
    
    init(id: String, index: Int, origin: Point, size: Size, color: Color, alpha: Alpha) {
        self.color = color
        super.init(id: id, index: index, origin: origin, size: size, alpha: alpha)
    }
    
    func update(color: Color) {
        self.color = color
        let userInfo: [AnyHashable : Any] = [ParamKey.color:color]
        NotificationCenter.default.post(name: Event.updateColor, object: self, userInfo: userInfo)
    }
}
