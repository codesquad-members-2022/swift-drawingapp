//
//  Makeable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/15.
//

import Foundation

protocol Makeable {
    func makeModel(type: DrawingModel.Type, data: [Any])
}
