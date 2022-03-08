//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class DrawingModelFactory {
    
    private let sizeFactory: SizeFactory
    private let pointFactory: PointFactory
    private let colorFactory: ColorFactory
    
    init(sizeFactory: SizeFactory, pointFactory: PointFactory, colorFactory: ColorFactory) {
        self.sizeFactory = sizeFactory
        self.pointFactory = pointFactory
        self.colorFactory = colorFactory
    }
    
    func makeRectangleModel() -> RectangleModel {
        let id = makeId()
        let size = sizeFactory.make()
        let point = pointFactory.make()
        let color = colorFactory.makeRandomColor()
        let alpha = Alpha.allCases.randomElement() ?? .transpar10
        return RectangleModel(id: id, point: point, size: size, color: color, alpha: alpha)
    }
    
    func makePhotoModel(url: URL) -> PhotoModel {
        let id = makeId()
        let size = sizeFactory.make()
        let point = pointFactory.make()
        let alpha = Alpha.transpar10
        return PhotoModel(id: id, point: point, size: size, alpha: alpha, url: url)
    }
    
    func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
}
