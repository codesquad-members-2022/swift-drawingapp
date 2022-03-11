//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

class DrawingModelFactory {
    private let colorFactory: ColorFactory
    
    init(colorFactory: ColorFactory) {
        self.colorFactory = colorFactory
    }
    
    func makeRectangleModel(origin: Point) -> RectangleModel {
        let id = makeId()
        let size = Size(width: 150, height: 120)
        let color = colorFactory.makeRandomColor()
        let alpha = Alpha.allCases.randomElement() ?? .transpar10
        return RectangleModel(id: id, origin: origin, size: size, color: color, alpha: alpha)
    }
    
    func makePhotoModel(origin: Point, url: URL) -> PhotoModel {
        let id = makeId()
        let size = Size(width: 150, height: 120)
        let alpha = Alpha.transpar10
        return PhotoModel(id: id, origin: origin, size: size, alpha: alpha, url: url)
    }
    
    func makeLabelModel(origin: Point) -> LabelModel {
        let id = makeId()
        let font = Font(name: "AppleSDGothicNeo-Regular", size: 16)
        let fontColor = colorFactory.makeRandomColor()
        let alpha = Alpha.allCases.randomElement() ?? .transpar10
        
        let uiFont = UIFont(name: font.name, size: font.size)
        let text = "asddfasddfasddfasddfasddfasddf"
        let labelSize = NSString(string: text).size(withAttributes: [.font:uiFont])
        let size = Size(width: labelSize.width, height: labelSize.height)
        
        return LabelModel(id: id, origin: origin, size: size, alpha: alpha, text: text, font: font, fontColor: fontColor)
    }
    
    func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
}
