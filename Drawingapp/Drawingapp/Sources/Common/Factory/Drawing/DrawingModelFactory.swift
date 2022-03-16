//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

class DrawingModelFactory: PlaneModelFactoryBase {
    func make(_ factory: DrawingModelFactoryable.Type, data: [Any]) -> DrawingModel {
        let id = makeId()
        let size = Size(width: 150, height: 120)
        let alpha = Alpha.allCases.randomElement() ?? .transpar10
        let origin = Point(x: Int.random(in: 0..<500), y: Int.random(in: 0..<500))
        return factory.make(id: id, origin: origin, size: size, alpha: alpha, data: data)
    }
    private func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
}

        
