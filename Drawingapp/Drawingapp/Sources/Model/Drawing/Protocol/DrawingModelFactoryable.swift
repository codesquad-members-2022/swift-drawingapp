//
//  DrawingModelFactoryable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol DrawingModelFactoryable {
    static func make(id: String, origin: Point, size: Size, alpha: Alpha, data: [Any]) -> DrawingModel
}
