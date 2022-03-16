//
//  Factoryable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol DrawingViewFactoryBase {
    func make(drawingable: Drawingable ) -> DrawingView
}

protocol PlaneModelFactoryBase {
    func make(factoryable: DrawingModelFactoryable.Type, data: [Any]) -> DrawingModel
}
