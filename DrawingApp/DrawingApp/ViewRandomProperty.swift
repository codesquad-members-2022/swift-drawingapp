//
//  ViewRandomProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

// typeAlias를 통해 튜플의 용도가 이름에서도 드러나도록 하였습니다.
// [수정] 값 타입 사용을 위해 typealias는 struct로 변경됩니다.
// [수정] 아래의 struct를 ViewRandomProperty의 서브타입으로 할까도 고민했지만, 아래의 값 타입은 어디서든 사용이 가능하겠다고 생각되어서 서브타입으로 하지 않았습니다.

struct RectSize {
    var width: Double
    var height: Double
}

struct RectPoint {
    var x: Double
    var y: Double
}

struct RectRGBColor {
    var r: Double
    var g: Double
    var b: Double
}

// 랜덤 프로퍼티를 소유한 뷰라는 의미의 이름을 넣게 되었습니다.
class ViewRandomProperty: ViewPropertyCreator {
    
    private let name: String
    private let id: String
    
    let size: RectSize
    let point: RectPoint
    
    let rgbValue: RectRGBColor
    let alpha: Double
    
    init(as name: String, using id: String, at point: RectPoint, size: RectSize, color: RectRGBColor, alpha: Double) {
        self.name = name
        self.id = id
        self.point = point
        self.size = size
        self.rgbValue = color
        self.alpha = alpha
    }
    
    init(as name: String, using id: String, from properties: FactoryProperties, color: RectRGBColor, alpha: Double) {
        self.name = name
        self.id = id
        self.point = RectPoint(x: properties.maxX, y: properties.maxY)
        self.size = RectSize(width: properties.width, height: properties.height)
        self.rgbValue = color
        self.alpha = alpha
    }
}

extension ViewRandomProperty: CustomStringConvertible {
    var description: String {
        "\(name) \(id), X:\(point.x),Y:\(point.y), W\(size.width), H\(size.height), R:\(rgbValue.r), G:\(rgbValue.g), B:\(rgbValue.b), Alpha:\(alpha)"
    }
}
